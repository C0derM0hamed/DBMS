#!/usr/bin/env bash

function show_table_menu {     
    select choice in "Create Table" "List Tables" "Drop Table" "Insert" "Select" "Update" "Delete" "Back to Main Menu"
    do
     
        if [[ ! -d "." ]]; then
            echo -e "${RED}Error: Database directory deleted unexpectedly!${NC}"
            cd .. 
            break 
        fi

        case $REPLY in
            1) create_table ;;
            2) ls -p | grep -v / ;; 
            3) 
                read -p "Enter table name to DROP: " tName
                if [[ -f "$tName" ]]; then
                    rm "$tName" ".$tName.meta" 2>/dev/null 
                    echo -e "${GREEN}Table deleted.${NC}"
                else
                    echo -e "${RED}Table not found.${NC}"
                fi
                ;;
            4) insert_row ;; 
            5) select_data ;; 
            6) update_row ;;
            7) delete_row ;;
            8) break ;; 
            *) echo -e "${RED}Invalid choice.${NC}" ;;
        esac
    done
}

function create_table {

    echo "Creating Table in .."
    read -r -p "Enter Table Name: " tName
    
    if [[ $tName = [0-9]* || $tName == *[^a-zA-Z0-9_]* || -z "$tName" ]]; then
        echo -e "${RED}Error: Invalid Table Name (Must start with letter, no special chars, not empty)${NC}"
        return
    fi

    if [[ -f "$tName" ]]; then
        echo -e "${RED}Error: Table already exists.${NC}"
        return
    fi

    read -p "Number of Columns: " nCols
    if [[ ! $nCols =~ ^[1-9][0-9]*$ ]]; then
        echo -e "${RED}Error: Invalid number.${NC}"
        return
    fi

    local metaData=""
    local pkSet=0

    for ((i=1; i<=nCols; i++)); do
        echo "--- Column $i ---"
        
        local cName=""
        
        while true; do
            read -r -p "Name: " cName
            
            if [[ -z "$cName" || $cName == *":"* || $cName == *"|"* ]]; then
                 echo -e "${RED}Error: Invalid Column Name (Cannot be empty or contain ':' '|')${NC}"
                 continue
            fi

            
            if [[ -n "$metaData" ]]; then
                 if echo "$metaData" | awk -F: -v RS="|" -v check="$cName" '$1 == check {exit 1}'; then
                     :
                 else
                     echo -e "${RED}Error: Column name '$cName' already exists. Try again.${NC}"
                     continue
                 fi
            fi
            
            break
        done

        echo "Type: 1) int  2) str"
        read -r -p "Select Type: " cTypeChoice
        case $cTypeChoice in
            1) cType="int" ;;
            2) cType="str" ;;
            *) echo -e "${RED}Invalid Choice, defaulting to str${NC}"; cType="str" ;;
        esac

        local cKey=""
        
        if (( pkSet == 0 )); then
            while true; do
                read -r -p "Make Primary Key? (y/n): " isPK
                if [[ "$isPK" == "y" || "$isPK" == "Y" ]]; then
                    cKey="pk"
                    pkSet=1
                    break
                elif [[ "$isPK" == "n" || "$isPK" == "N" ]]; then
                    cKey=""
                    break
                else
                    echo -e "${RED}Invalid input.${NC}"
                fi
            done
        else
            cKey=""
        fi

        if (( i == nCols )); then
            metaData+="$cName:$cType:$cKey"
        else
            metaData+="$cName:$cType:$cKey|"
        fi
    done

    if (( pkSet == 0 )); then
        echo -e "${RED}Error: Could not create table without a Primary Key.${NC}"
        return
    fi

    touch "$tName"
    echo "$metaData" > ".$tName.meta"
    echo -e "${GREEN}Table '$tName' created successfully.${NC}"
}