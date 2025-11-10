#!/usr/bin/env bash
# Task 2 : Generate CSV report of Active employees
# - Robust connection & schema validation
# - Clear errors with logging
# - CSV with headers (employee_id,name,department,salary,status)
# - Exact required outputs on success
set -euo pipefail

DB_NAME="employee_company"
OUT_CSV="employee_report.csv"
TMP_CSV="${OUT_CSV}.tmp"
LOG_DIR="logs"
mkdir -p "$LOG_DIR"

log()  { printf "[%(%F %T)T] %s\n" -1 "$*" >> "$LOG_DIR/generate_report.log"; }
fail() { log "ERROR: $*"; echo "❌ $*"; exit 1; }

# --- prerequisites ---
command -v mysql >/dev/null 2>&1 || fail "MySQL client (mysql) not found in PATH"

# --- credentials ---
read -rp "MySQL username: " MYSQL_USER
read -srp "MySQL password: " MYSQL_PASS; echo

mysql_conn=( mysql -u"$MYSQL_USER" -p"$MYSQL_PASS" --batch --skip-column-names )

# --- connection test & select DB ---
${mysql_conn[@]} -e "USE ${DB_NAME}; SELECT 1;" >/dev/null 2>&1 \
  || fail "Cannot connect to DB '${DB_NAME}'. Make sure import_db.sh ran successfully."

echo "✅ Connected to database successfully!"
log "Connected to ${DB_NAME}"

# --- schema validation: table existence ---
tbl_exists=$(${mysql_conn[@]} -e "
SELECT COUNT(*) FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_SCHEMA='${DB_NAME}' AND TABLE_NAME='employees';
")
[[ "$tbl_exists" == "1" ]] || fail "Table 'employees' not found in database '${DB_NAME}'. Run ./import_db.sh first."

# --- schema validation: required columns present ---
required=(employee_id first_name last_name department salary status)
# read actual columns into array
mapfile -t actual < <(${mysql_conn[@]} -e "
SELECT COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA='${DB_NAME}' AND TABLE_NAME='employees'
ORDER BY ORDINAL_POSITION;
")

missing=()
for col in "${required[@]}"; do
  found=0
  for a in "${actual[@]}"; do
    [[ "$a" == "$col" ]] && { found=1; break; }
  done
  (( found )) || missing+=("$col")
done

if (( ${#missing[@]} > 0 )); then
  fail "Table 'employees' is missing required column(s): ${missing[*]}"
fi
log "Schema validated OK"

# --- build CSV with headers ---
# Note: we use tabs from mysql and convert to commas reliably.
# Also cast salary to DECIMAL(10,2) for uniform formatting.
{
  echo "employee_id,name,department,salary,status"
  mysql -u"$MYSQL_USER" -p"$MYSQL_PASS" --batch --skip-column-names -e "
    USE ${DB_NAME};
    SELECT
      e.employee_id,
      CONCAT(e.first_name,' ',e.last_name) AS name,
      e.department,
      CAST(e.salary AS DECIMAL(10,2)) AS salary,
      e.status
    FROM employees e
    WHERE e.status='Active'
    ORDER BY e.department, e.last_name, e.first_name;
  " | tr '\t' ','
} > "$TMP_CSV" 2>>"$LOG_DIR/generate_report.log" || fail "Failed to query/export data (see logs)."

# --- basic CSV validation ---
read -r header < "$TMP_CSV"
[[ "$header" == "employee_id,name,department,salary,status" ]] || fail "CSV header invalid"

# Ensure no empty employee_id rows
if ! awk -F',' 'NR>1 && $1=="" {bad=1} END{exit bad?1:0}' "$TMP_CSV"; then
  fail "CSV contains rows with empty employee_id"
fi

# Atomic move to final path
mv "$TMP_CSV" "$OUT_CSV"

# --- count exported rows ---
exported=$(( $(wc -l < "$OUT_CSV") - 1 ))

# --- success outputs (match assignment spec) ---
echo "✅ Exported ${exported} active employees to ${OUT_CSV}"
echo "✅ Report generation complete!"

log "Report generated: ${OUT_CSV} rows=${exported}"
exit 0
