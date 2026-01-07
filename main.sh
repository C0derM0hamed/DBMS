#!/bin/bash

export SCRIPT_PATH=$(pwd)
export DATA_PATH="$SCRIPT_PATH/DBMS"

# 1. Import (Source) the other script files to use their functions
# source ./db_operations.sh
# source ./table_operations.sh
# source ./data_operations.sh

# 2. Define a global variable for the database storage path
# 3. Create the main DBMS directory if it doesn't exist

function main_menu {
select var in "Create Db" "List Db" "Drop Db" "Connect Db"  "Exit" 
do 
    case $REPLY in 
        1 ) create_db 
        ;;
        2 ) list_dbs 
        ;;
        3 ) drop_db 
        ;;
        4 ) connect_db 
        ;;
        5 ) echo "Exiting..."; break 
        ;;
        * ) echo "Invalid option. Please choose 1-5." ;;
    esac
done
}

main_menu