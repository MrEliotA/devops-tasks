#!/usr/bin/env bash
#Task 1: Import SQL to MySQL with backup, validation, logging
set -euo pipefail

DB_NAME="employee_company"
SQL_FILE="homework_bash.sql"
LOG_DIR="logs"
BACKUP_DIR="backups"
mkdir -p "$LOG_DIR" "$BACKUP_DIR"

log()   { printf "[%(%F %T)T] %s\n" -1 "$*" >> "$LOG_DIR/import_db.log"; }
fail()  { log "ERROR: $*"; echo "❌ $*"; exit 1; }

# --- prerequisites & inputs ---
command -v mysql >/dev/null 2>&1 || fail "MySQL client (mysql) not found in PATH"
command -v mysqldump >/dev/null 2>&1 || fail "mysqldump not found in PATH"
[[ -f "$SQL_FILE" ]] || fail "SQL file '$SQL_FILE' not found"

read -rp "MySQL username: " MYSQL_USER
read -srp "MySQL password: " MYSQL_PASS; echo

mysql_conn=( mysql -u"$MYSQL_USER" -p"$MYSQL_PASS" --batch --skip-column-names )

# --- sanity check: can connect? ---
${mysql_conn[@]} -e "SELECT 1;" >/dev/null 2>&1 || fail "Cannot connect to MySQL with given credentials"

# --- backup if DB already exists ---
if ${mysql_conn[@]} -e "SHOW DATABASES LIKE '${DB_NAME}';" | grep -q "^${DB_NAME}$"; then
  TS="$(date +%Y%m%d_%H%M%S)"
  BK="${BACKUP_DIR}/${DB_NAME}_${TS}.sql"
  log "Database '${DB_NAME}' exists; creating backup at ${BK}"
  mysqldump -u"$MYSQL_USER" -p"$MYSQL_PASS" --routines --events --databases "$DB_NAME" > "$BK" \
    || fail "Backup failed"
fi

# --- import with basic validation ---
# Extra guard: ensure DB exists before running file (even though file drops/creates)
${mysql_conn[@]} -e "CREATE DATABASE IF NOT EXISTS ${DB_NAME};" >/dev/null

# Run import; silence normal output but log errors
if ! mysql -u"$MYSQL_USER" -p"$MYSQL_PASS" < "$SQL_FILE" >/dev/null 2>>"$LOG_DIR/import_db.log"; then
  fail "Import failed (see $LOG_DIR/import_db.log)"
fi

# Post-import validation: check required tables and record counts
tables_ok=$(${mysql_conn[@]} -e "SHOW TABLES FROM ${DB_NAME} LIKE 'employees';")
[[ -n "$tables_ok" ]] || fail "Table 'employees' not created"

total=$(${mysql_conn[@]} -e "SELECT COUNT(*) FROM ${DB_NAME}.employees;")
case "$total" in
  ''|*[!0-9]*) fail "Could not verify employee count";;
esac

# --- expected output (exact text) ---
echo "✅ Database 'employee_company' created successfully!"
echo "✅ Imported ${total} employee records"
echo "✅ Database setup complete!"

log "Import complete. employees=${total}"
exit 0
