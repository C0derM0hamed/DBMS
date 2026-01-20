

# My Bash DBMS Project

This project is a simple Database Management System (DBMS) made using Bash scripts. It allows you to create databases, build tables with schemas, and perform data operations like inserting, updating, and deleting records.

## Features

### Database Control

* You can create, list, or delete database folders.
* The script "connects" to a database by moving inside its directory to manage its tables.

### Table Design

* Hidden meta files (starting with `.`) store the table structure like column names and types.
* Supports integer and string data types.
* Every table must have a Primary Key to keep the data unique.

### Data Operations (CRUD)

* Insert: Checks for correct data types and ensures the Primary Key is not duplicated.
* Select: Displays data in a clean table format using the `column` command.
* Update: Removes the old record and lets you enter new data for that ID.
* Delete: Removes a specific row based on the Primary Key.

### Validations

* Prevents the use of `|` in data because it is used as a separator in the files.
* Validates names to make sure they don't have spaces or weird characters.
* If you delete a folder manually while the script is running, it detects the error and goes back to the main menu.

## Project Files

* main.sh: The main file that starts the program and shows the first menu.
* db_operations.sh: Handles creating and switching between databases.
* table_operations.sh: Handles creating tables and managing their columns.
* data_operations.sh: Handles the actual data inside the tables (Insert, Select, Update, Delete).

## How to use it

1. Make sure all files are in the same folder.
2. Give the scripts permission to run:
`chmod +x *.sh`
3. Run the project:
`./main.sh`

## Colors used

I used ANSI colors to make the output easier to read:

* Green for success messages.
* Red for any errors or invalid inputs.
* Yellow for exit messages.

---