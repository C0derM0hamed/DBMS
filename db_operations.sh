REPO_DIR="$HOME/.db"
mkdir -p "$REPO_DIR"

function create_db {
    read -p "Enter DB name: " name
    name=$(echo "$name" | tr -d ' ')
    if [[ -d "$REPO_DIR/$name" ]]; then
        echo "Error: Database already exists."
    else
        mkdir -p "$REPO_DIR/$name"
        echo "Database '$name' created."
    fi
}

function list_dbs {
    if [[ -d "$REPO_DIR" ]]; then
            echo "Available Databases:"
            ls "$REPO_DIR"
        else
            echo "No databases found."
        fi
}

function connect_db {
    read -p "Enter DB name to connect: " name
    name=$(echo "$name" | tr -d ' ')
    if [[ -d "$REPO_DIR/$name" ]]; then
        echo "Connecting to '$name'..."

        show_table_menu "$name"
    else
        echo "Database '$name' not found."
    fi
}

function drop_db {
    if [[ -d "$REPO_DIR" ]]; then
            read -p "Enter DB name to drop: " name
            name=$(echo "$name" | tr -d ' ')
            if [[ -d "$REPO_DIR/$name" ]]; then
                rm -r "$REPO_DIR/$name"
                echo "Database '$name' dropped."
            else
                echo "No database found with this name."
            fi
        else
            echo "No databases exist yet."
        fi
}