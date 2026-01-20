#!/usr/bin/env bash

function insert_row {
    read -p "Enter Table Name: " tName

    if [[ ! -f "$tName" || ! -f ".$tName.meta" ]]; then
        echo "Error: Table or Metadata not found."
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
            read -p "Enter value for $cName ($cType): " val
          
            if [[ -z "$val" ]]; then echo "Value cannot be empty."; continue; fi

            if [[ "$val" == *"|"* ]]; then echo "Invalid character '|' used."; continue; fi
    
            if [[ "$cType" == "int" && ! "$val" =~ ^[0-9]+$ ]]; then
                echo "Error: Must be a numeric value."
                continue
            fi
         
            if [[ "$cKey" == "pk" ]]; then
                if cut -d'|' -f1 "$tName" | grep -qx "$val"; then
                    echo "Error: ID '$val' already exists (Primary Key)."
                    continue
                fi
            fi
            break
        done
        row+="$val|"
    done
    echo "${row%|}" >> "$tName" 
    echo "Row inserted successfully."
}

function select_data {
    read -p "Enter table name: " tName
    if [[ ! -f "$tName" ]]; then echo "Table not found."; return; fi
    
    echo "1) Select All"
    echo "2) Search by Value"
    read -p "Choice: " choice
    case $choice in
        1) column -t -s '|' "$tName" ;;
        2) 
            read -p "Enter value to find: " val
            grep "$val" "$tName" | column -t -s '|' ;;
        *) echo "Invalid choice." ;;
    esac
}

function delete_row {
    read -p "Enter Table Name: " tName
    if [[ ! -f "$tName" ]]; then echo "Table not found."; return; fi
    
    read -p "Enter Primary Key (ID) to delete: " pk
    if cut -d'|' -f1 "$tName" | grep -qx "$pk"; then
        sed -i "/^$pk|/d" "$tName"
        echo "Record deleted."
    else
        echo "ID not found."
    fi
}

function update_row {
    read -p "Enter Table Name: " tName
    if [[ ! -f "$tName" ]]; then echo "Table not found."; return; fi
    
    read -p "Enter Primary Key (ID) to update: " pk
    if cut -d'|' -f1 "$tName" | grep -qx "$pk"; then
        sed -i "/^$pk|/d" "$tName"
        echo "Old record removed. Enter new data:"
        insert_row 
        echo "ID not found."
    fi
}