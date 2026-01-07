function insert_row {
    # 1. Read the metadata file of the table line by line
    # 2. For each column defined in meta:
    #    - Prompt user for input
    #    - VALIDATION: If type is 'int', check if input is numeric (Regex)
    #    - PK CHECK: If column is 'pk', check if value exists in data file (grep)
    # 3. If all inputs are valid, join them with a separator (e.g., | )
    # 4. Append the final string as a new line to the data file ( >> )
}

function select_data {
    # 1. Ask user: "Select All or Select by Column?"
    # 2. If All: Use 'column -t -s' to display the file content
    # 3. If by Column:
    #    - Ask for the value to search for
    #    - Use 'awk' to find and print the matching row
}

function delete_row {
    # 1. Ask for the Primary Key value of the row to delete
    # 2. Check if the value exists
    # 3. Use 'sed' to remove the line containing that value (sed -i)
}

function update_row {
    # 1. Ask for the PK value of the row to update
    # 2. Ask for the column name to change
    # 3. Ask for the new value
    # 4. Validate the new value (type and uniqueness)
    # 5. Use 'awk' or 'sed' to replace the old value with the new one
}