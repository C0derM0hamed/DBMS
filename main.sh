#!/usr/bin/env bash

export RED='\033[0;31m'
export GREEN='\033[0;32m'
export YELLOW='\033[1;33m' 
export NC='\033[0m'

export DATA_PATH="$HOME/.DBMS"

source ./db_operations.sh
source ./table_operations.sh
source ./data_operations.sh

if [[ ! -d "$DATA_PATH" ]]; then
    mkdir -p "$DATA_PATH"
fi

function main_menu {
    PS3="Main Menu >> "
    select var in "Create Db" "List Db" "Drop Db" "Connect Db" "Exit" 
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
            5 ) echo -e "${YELLOW}Exiting...${NC}"; break ;;
            * ) echo -e "${RED}Invalid option. Please choose 1-5.${NC}" ;;
        esac
    done
}

main_menu