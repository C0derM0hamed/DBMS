#!/usr/bin/env bash

function insert_row {
    local tName=$1
    if [[ -z "$tName" ]]; then
        read -p "Enter Table Name: " tName
    fi

    if [[ ! -f "$tName" || ! -f ".$tName.meta" ]]; then
        echo -e "${RED}Error: Table or Metadata not found.${NC}"
        return
    fi

    local meta=$(cat ".$tName.meta")
    local row=""
    IFS='|' read -ra COLUMNS <<< "$meta"

    for col in "${COLUMNS[@]}"; do
        local cName=$(echo $col | cut -d: -f1)
        local cType=$(echo $col | cut -d: -f2)
        local cKey=$(echo $col | cut -d: -f3)

        while true; do
            read -p "Enter $cName ($cType): " val
          
            if [[ -z "$val" ]]; then echo -e "${RED}Value cannot be empty.${NC}"; continue; fi
            if [[ "$val" == *"|"* ]]; then echo -e "${RED}Invalid char '|'.${NC}"; continue; fi
            
            if [[ "$cType" == "int" && ! "$val" =~ ^[0-9]+$ ]]; then
                echo -e "${RED}Error: Must be a number.${NC}"
                continue
            fi
         
            if [[ "$cKey" == "pk" ]]; then
                if cut -d'|' -f1 "$tName" | grep -qx "$val"; then
                    echo -e "${RED}Error: ID '$val' exists (PK).${NC}"
                    continue
                fi
            fi
            break
        done
        row+="$val|"
    done
    
    echo "${row%|}" >> "$tName" 
    echo -e "${GREEN}Row inserted successfully.${NC}"
}

function select_data {
    read -p "Enter table name: " tName
    if [[ ! -f "$tName" ]]; then echo -e "${RED}Table not found.${NC}"; return; fi
    
    echo "1) Select All"
    echo "2) Search by Value"
    read -p "Choice: " choice
    case $choice in
        1) 
            if [[ ! -s "$tName" ]]; then
                echo -e "${RED}Table is empty.${NC}"
            else
                column -t -s '|' "$tName" 
            fi
            ;;
        2) 
            read -p "Enter value to find: " val
           
            result=$(grep "$val" "$tName")
            
            if [[ -z "$result" ]]; then
                echo -e "${RED}Nothing found.${NC}"
            else
                echo "$result" | column -t -s '|'
            fi 
            ;;
        *) echo -e "${RED}Invalid choice.${NC}" ;;
    esac
}

function delete_row {
    read -p "Enter Table Name: " tName
    if [[ ! -f "$tName" ]]; then echo -e "${RED}Table not found.${NC}"; return; fi
    
    read -p "Enter Primary Key (ID) to delete: " pk
    
    if cut -d'|' -f1 "$tName" | grep -qx "$pk"; then
        sed -i "/^$pk|/d" "$tName"
        echo -e "${GREEN}Record deleted.${NC}"
    else
        echo -e "${RED}ID not found.${NC}"
    fi
}

function update_row {
    read -p "Enter Table Name: " tName
    if [[ ! -f "$tName" ]]; then echo -e "${RED}Table not found.${NC}"; return; fi
    
    read -p "Enter Primary Key (ID) to update: " pk  
  
    if cut -d'|' -f1 "$tName" | grep -qx "$pk"; then
              
        sed -i "/^$pk|/d" "$tName"
        
        echo -e "${GREEN}Old record removed.${NC}"
        echo "Please enter the new data (You can enter the same ID or a new one):"
        
        insert_row "$tName"
        
    else
        echo -e "${RED}ID not found.${NC}"
    fi
}