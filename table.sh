#!/usr/bin/bash
CurrentDB=$1
PS3="$CurrentDB >> "

select var in "Create Table" "List Tables" "Drop Table" "Insert into Table" "Delete from Table" "Select from Table" "Back to Main Menu"
do
    case $REPLY in 
          1 ) 
              echo "Creating Table..."
              ;;
          2 )
            echo "Listing Tables..."
            ;;
          3 )
             echo "Dropping Table..."
             ;;
          4 )  
             echo "Inserting into Table..."
             ;;
          5 ) 
            echo "Deleting from Table..."
            ;;
          6 ) 
            echo "Selecting from Table..."
            ;;
          7 )
            echo "Returning to Main Menu..."
            break
            ;;
      esac
done    