#!/usr/bin/bash

select var in "Create Db" "List Db" "Drop Db" "Connect Db"  "Exit" 
do 
    case $REPLY in 
          1 ) 
              read -p "enter db name :" name
              name=$(echo $name | tr -d ' ')
              if [[ -d ~/.db/$name ]];then
                    echo "database already exists"
              else
                  if [[ ! -d ~/.db/ ]]; then
                      mkdir ~/.db/
                  else  
                   mkdir ~/.db/$name
                  fi
               fi
          ;;
          2 )
            if [[ -d ~/.db/ ]]; then
                ls ~/.db/ 
            else 
                echo "no db found"
            fi
          ;;
          3 )
             if [[ -d ~/.db/ ]]; then
                read -p "enter db want to drop :" name 
                name=$(echo $name | tr -d ' ')
                if [[ -d ~/.db/$name ]]; then
                    rm -r ~/.db/$name
                    echo "database dropped"
                else
                    echo "no database found"
                fi
             else
                echo "no db found"
             fi
          ;;
          4 )  
             echo "Connect to db..."
                read -p "enter db name to connect :" name
                name =$(echo $name | tr -d ' ')
                if [[ -d ~/.db/$name ]]; then
                    cd ~/.db/$name
                    source ~/.db/table.sh $name
                else
                    echo "no database found"
          ;;
          5 ) 
            echo "Exiting..."
            break
          ;;
      esac
done

              