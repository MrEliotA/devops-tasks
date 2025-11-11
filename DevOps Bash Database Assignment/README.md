# DevOps Bash Database Assignment

MySQL + Bash scripts for importing data, generating a CSV report, and re-importing the CSV into a new table — with validation, backups, and logging.

## Table of Contents
- [Overview](#overview)
- [Features](#features)
- [File Structure](#file-structure)
- [Prerequisites](#prerequisites)
- [Setup](#setup)
- [Usage](#usage)
- [Expected Output](#expected-output)
- [Sample Logs](#sample-logs)        
- [How It Works](#how-it-works)
- [Validation, Backup, Logging](#validation-backup-logging)
- [Testing](#testing)
- [Troubleshooting](#troubleshooting)
- [FAQ](#faq)
- [Support](#support)

---

## Overview
This assignment includes three Bash scripts that work with a MySQL database:
1) Import the database schema and seed data  
2) Generate a CSV report of active employees  
3) Import that CSV into a new table

---

## Features
- ✅ Robust **connection checks**
- ✅ **Schema validation** (table + required columns)
- ✅ Automatic **database backup** before import (if DB exists)
- ✅ **CSV export** with headers
- ✅ **Duplicate handling** on CSV import via `REPLACE`
- ✅ Clear user messages + proper **exit codes**
- ✅ Per-script **logging** to `logs/`
- ✅ Outputs match the assignment’s **Expected Output**

---

## File Structure
```
DevOps Bash Database Assignment/
├── import_db.sh           # Task 1: Database import
├── generate_report.sh     # Task 2: Report generator (Active employees → CSV)
├── import_csv.sh          # Task 3: CSV → employee_reports
├── homework_bash.sql      # Database schema + seed data
├── employee_report.csv    # Generated report (created by script)
├── backups/               # Auto-created database dumps
├── logs/                  # Log files per script
└── README.md              # This file
```

---

## Prerequisites
- MySQL Server + Client (`mysql`, `mysqldump`)
- Bash shell
- Permissions to run scripts (`chmod +x *.sh`)
- MySQL service running locally (e.g. `sudo systemctl start mysql`)

---

## Setup
```bash
# From project root
chmod +x *.sh
sudo systemctl start mysql   # if not already running
```

---

## Usage

### 1) Import the database
```bash
./import_db.sh
```

### 2) Generate the CSV report (Active employees)
```bash
./generate_report.sh
```

### 3) Import the CSV into a new table
```bash
./import_csv.sh
```

> Each script will prompt for your MySQL username and password.

---

## Expected Output

### After `import_db.sh`
```
✅ Database 'employee_company' created successfully!
✅ Imported 50 employee records
✅ Database setup complete!
```

### After `generate_report.sh`
```
✅ Connected to database successfully!
✅ Exported 41 active employees to employee_report.csv
✅ Report generation complete!
```

### After `import_csv.sh`
```
✅ Created table 'employee_reports' successfully!
✅ Imported 41 records from CSV file
✅ CSV import complete!
```

> Counts are based on the provided SQL. If you modify the data, the scripts compute and print the real counts.

---

## Sample Logs

Real log snippets captured from `logs/*.log` during test runs.

### `logs/import_db.log`
```text
[2025-11-10 21:58:27] Database 'employee_company' exists; creating backup at backups/employee_company_20251110_215827.sql
[2025-11-10 21:58:27] Import complete. employees=50
[2025-11-10 22:20:58] ERROR: Cannot connect to MySQL with given credentials
[2025-11-10 22:21:20] Database 'employee_company' exists; creating backup at backups/employee_company_20251110_222120.sql
[2025-11-10 22:21:20] Import complete. employees=50
[2025-11-10 22:32:05] Database 'employee_company' exists; creating backup at backups/employee_company_20251110_223205.sql
[2025-11-10 22:32:05] Import complete. employees=50
```

### `logs/generate_report.log`
```text
[2025-11-10 22:06:18] ERROR: Table 'employees' missing required columns
[2025-11-10 22:09:07] ERROR: Table 'employees' missing required columns
[2025-11-10 22:21:32] ERROR: Table 'employees' missing required columns
[2025-11-10 22:23:16] Connected to employee_company
[2025-11-10 22:23:16] Schema validated OK
[2025-11-10 22:23:21] Report generated: employee_report.csv rows=41
[2025-11-10 22:32:21] Connected to employee_company
[2025-11-10 22:32:21] Schema validated OK
[2025-11-10 22:32:21] Report generated: employee_report.csv rows=41
```

### `logs/import_csv.log`
```text
[2025-11-10 22:24:44] CSV imported into employee_reports rows=41
[2025-11-10 22:32:45] CSV imported into employee_reports rows=41
```

---

## How It Works

### `import_db.sh` (Task 1)
- Verifies `mysql` and `mysqldump`
- Backs up existing `employee_company` (if present) into `backups/employee_company_YYYYmmdd_HHMMSS.sql`
- Imports `homework_bash.sql`
- Validates that `employees` exists and prints total rows

### `generate_report.sh` (Task 2)
- Connects to `employee_company`
- Validates required columns on `employees`:
  - `employee_id, first_name, last_name, department, salary, status`
- Exports only **Active** employees with header:
  ```
  employee_id,name,department,salary,status
  ```
- Writes to `employee_report.csv` and prints exported row count

### `import_csv.sh` (Task 3)
- Validates CSV file and header
- Creates `employee_reports` (if not exists) with:
  - `employee_id` as **PRIMARY KEY** (dedup)
  - `status` ENUM aligned with source
- Imports CSV via `LOAD DATA LOCAL INFILE` using **REPLACE**
- Prints imported row count

---

## Validation, Backup, Logging

**Data Validation**
- MySQL connectivity and DB selection
- Table existence + required columns
- CSV header format
- Non-empty `employee_id` values in CSV

**Backups**
- If the target DB already exists, an automatic dump is created under `backups/`.

**Logging**
- `logs/import_db.log`
- `logs/generate_report.log`
- `logs/import_csv.log`

Use logs for detailed error context.

---

## Testing
Quick checks you can run anytime:

```bash
# List databases
mysql -u <user> -p -e "SHOW DATABASES;"

# Table present?
mysql -u <user> -p -e "USE employee_company; SHOW TABLES LIKE 'employees';"

# Column list
mysql -u <user> -p -e "
SELECT COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA='employee_company' AND TABLE_NAME='employees'
ORDER BY ORDINAL_POSITION;"

# Active employees count
mysql -u <user> -p -e "USE employee_company; SELECT COUNT(*) FROM employees WHERE status='Active';"

# CSV created?
ls -la employee_report.csv

# New table present?
mysql -u <user> -p -e "USE employee_company; SHOW TABLES LIKE 'employee_reports';"
```

---

## Troubleshooting

- **Cannot connect to DB**  
  Ensure MySQL is running, credentials are correct, and `import_db.sh` completed.

- **Table `employees` not found**  
  Run `./import_db.sh` and confirm `homework_bash.sql` is in the same directory.

- **CSV header invalid**  
  The export must start with: `employee_id,name,department,salary,status`.  
  Delete any edited CSV and rerun `./generate_report.sh`.

- **CSV contains rows with empty `employee_id`**  
  Source data must include valid `employee_id` for all rows.

- **LOAD DATA LOCAL INFILE disabled**  
  Client is invoked with `--local-infile=1`. If the server denies it, enable `local_infile=ON` in MySQL server config or grant appropriately.

- **Backup issues**  
  Check disk space and write permissions for the `backups/` folder.

Always consult `logs/*.log` for detailed errors.

---

## FAQ

**Where do I change database or file names?**  
Edit `DB_NAME`, `OUT_CSV`, and `TABLE_NAME` variables at the top of each script.

**Will scripts overwrite data?**  
`import_db.sh` recreates the DB from `homework_bash.sql` (after making a backup if the DB exists).  
`import_csv.sh` uses `REPLACE` on `employee_id` to avoid duplicates.

**Can I target a remote MySQL host?**  
Yes — add `-h <host>` to the `mysql` command arrays (or export `MYSQL_HOST` and interpolate).

**How do I re-run cleanly?**  
Let `import_db.sh` recreate the DB, remove old `employee_report.csv` if needed, then run the three scripts in order.

---

## Support
If you encounter issues, check the `logs/` directory for details or contact your instructor.
