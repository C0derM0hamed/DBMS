#!/usr/bin/env bash
function create_db {
    read -p "Enter DB name: " name
    name=$(echo "$name" | tr -d ' ')
    if [[ -d "$DATA_PATH/$name" ]]; then
        echo "Error: Database already exists."
    else
        mkdir -p "$DATA_PATH/$name"
        echo "Database '$name' created."
    fi
}

function list_dbs {
    if [[ -d "$DATA_PATH" ]]; then
            echo "Available Databases:"
            ls "$DATA_PATH"
        else
            echo "No databases found."
        fi
}

function connect_db {
    read -p "Enter DB name to connect: " name
    name=$(echo "$name" | tr -d ' ')
    if [[ -d "$DATA_PATH/$name" ]]; then
        echo "Connecting to '$name'..."

        show_table_menu "$name"
    else
        echo "Database '$name' not found."
    fi
}

function drop_db {
    if [[ -d "$DATA_PATH" ]]; then
            read -p "Enter DB name to drop: " name
            name=$(echo "$name" | tr -d ' ')
            if [[ -d "$DATA_PATH/$name" ]]; then
                rm -r "$DATA_PATH/$name"
                echo "Database '$name' dropped."
            else
                echo "No database found with this name."
            fi
        else
            echo "No databases exist yet."
        fi
}