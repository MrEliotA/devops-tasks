#!/usr/bin/env bash
# Task 3: Import CSV to new table with duplicate handling, validation, logging
set -euo pipefail

DB_NAME="employee_company"
CSV_FILE="employee_report.csv"
TABLE_NAME="employee_reports"
LOG_DIR="logs"
mkdir -p "$LOG_DIR"

log()   { printf "[%(%F %T)T] %s\n" -1 "$*" >> "$LOG_DIR/import_csv.log"; }
fail()  { log "ERROR: $*"; echo "❌ $*"; exit 1; }

command -v mysql >/dev/null 2>&1 || fail "MySQL client (mysql) not found in PATH"
[[ -f "$CSV_FILE" ]] || fail "CSV file '$CSV_FILE' not found. Run generate_report.sh first."

read -rp "MySQL username: " MYSQL_USER
read -srp "MySQL password: " MYSQL_PASS; echo

# Use --local-infile for LOAD DATA
mysql_conn=( mysql -u"$MYSQL_USER" -p"$MYSQL_PASS" --batch --local-infile=1 )

# Connection check
${mysql_conn[@]} -e "USE ${DB_NAME}; SELECT 1;" >/dev/null 2>&1 || fail "Cannot connect to DB '${DB_NAME}'"

# Validate CSV header
read -r header < "$CSV_FILE"
[[ "$header" == "employee_id,name,department,salary,status" ]] || fail "CSV header invalid: expected 'employee_id,name,department,salary,status'"

# Create target table with constraints; PK on employee_id to dedupe
${mysql_conn[@]} -e "
CREATE TABLE IF NOT EXISTS ${DB_NAME}.${TABLE_NAME} (
  employee_id VARCHAR(10) PRIMARY KEY,
  name        VARCHAR(101) NOT NULL,
  department  VARCHAR(50)  NOT NULL,
  salary      DECIMAL(10,2) NOT NULL,
  status      ENUM('Active','Inactive','On Leave') NOT NULL
) ENGINE=InnoDB;
" >/dev/null

echo "✅ Created table '${TABLE_NAME}' successfully!"

# Import with duplicate handling:
# REPLACE ensures that if employee_id already exists, the row is replaced (dedup)
${mysql_conn[@]} -e "
LOAD DATA LOCAL INFILE '$(realpath "$CSV_FILE")'
REPLACE INTO TABLE ${DB_NAME}.${TABLE_NAME}
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '\"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(employee_id, name, department, @salary_raw, status)
SET salary = CAST(@salary_raw AS DECIMAL(10,2));
" >/dev/null 2>>"$LOG_DIR/import_csv.log" || fail "CSV import failed (see $LOG_DIR/import_csv.log)"

# Verify import
imported=$(${mysql_conn[@]} -N -s -e "SELECT COUNT(*) FROM ${DB_NAME}.${TABLE_NAME};")
case "$imported" in
  ''|*[!0-9]*) fail "Could not verify import count";;
esac

echo "✅ Imported ${imported} records from CSV file"
echo "✅ CSV import complete!"

log "CSV imported into ${TABLE_NAME} rows=${imported}"
exit 0
