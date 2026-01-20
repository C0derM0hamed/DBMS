#!/usr/bin/env bash

function create_db {
    read -p "Enter DB name: " name
    name=$(echo "$name" | tr -d ' ')
 
    if [[ -z "$name" || ! "$name" =~ ^[a-zA-Z0-9]+$ ]]; then
        echo -e "${RED}Error: Invalid name. Use letters and numbers only.${NC}"
        return
    fi

    if [[ -d "$DATA_PATH/$name" ]]; then
        echo -e "${RED}Error: Database already exists.${NC}"
    else
        mkdir -p "$DATA_PATH/$name"
        echo -e "${GREEN}Database '$name' created.${NC}"
    fi
}

function list_dbs {
   
    if [[ -d "$DATA_PATH" && "$(ls -A $DATA_PATH)" ]]; then
        echo -e "${YELLOW}--- Available Databases ---${NC}"
        ls "$DATA_PATH"
    else
        echo -e "${RED}No databases found.${NC}"
    fi
}

function connect_db {
    read -p "Enter DB name to connect: " name
    name=$(echo "$name" | tr -d ' ')

    if [[ -d "$DATA_PATH/$name" ]]; then
        cd "$DATA_PATH/$name"
        echo -e "${GREEN}Connecting to '$name'...${NC}"
           
        export PS3="$name >> "       
        
        show_table_menu
        
        export PS3="Main Menu >> "
        cd - > /dev/null
    else
        echo -e "${RED}Database '$name' not found.${NC}"
    fi
}

function drop_db {
    read -p "Enter DB name to drop: " name
    name=$(echo "$name" | tr -d ' ')
    
    if [[ -z "$name" ]]; then echo -e "${RED}Name cannot be empty${NC}"; return; fi

    if [[ -d "$DATA_PATH/$name" ]]; then
        rm -r "$DATA_PATH/$name"
        echo -e "${GREEN}Database '$name' dropped.${NC}"
    else
        echo -e "${RED}No database found with this name.${NC}"
    fi
}