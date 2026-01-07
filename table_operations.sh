function show_table_menu {
    # 1. Use 'select' to create the Table Menu:
    # Options: Create Table, List Tables, Drop Table, Insert, Select, Update, Delete, Back
    
    # 2. Use 'case' to call the relevant functions
    # 3. Handle 'Back' by returning to the main menu
}

function create_table {
    # 1. Ask for Table Name
    # 2. Check if file already exists
    # 3. Ask user: "How many columns?"
    # 4. Loop based on Number of Columns:
    #    - Ask for Column Name
    #    - Ask for Column Type (int or str)
    #    - Ask if it's the Primary Key (ensure only one PK exists)
    # 5. Store this info in a hidden metadata file (e.g., .tablename.meta)
    # 6. Create the actual data file (touch tablename)
}