#! /bin/bash

Color_Off='\033[0m'       # Text Reset

# Regular Colors
Black='\033[0;30m'        # Black
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Blue='\033[0;34m'         # Blue
Purple='\033[0;35m'       # Purple
Cyan='\033[0;36m'         # Cyan
White='\033[0;37m'

PRIVATEIP=$(hostname -I)
printf "WANT TO CHANGE REPLICATION FACTOR FOR: \n\t ${Green}1. ALL THE KEYSPACES EXCEPT SYSTEM KEYSPACES ${Color_Off} \n\t ${Cyan}2. ALL THE KEYSPACES CREATED BY ALTERNATOR ${Color_Off} \n\t ${Yellow}3. MANUALLY PROVIDE THE LIST OF KEYSPACES ${Color_Off} \n"
read -p "CHOOSE 1/2/3: " OPTION
if [ "$OPTION" == "1" ]
then 
    printf "ENTER THE VALUE OF ${Purple}REPLICATION FACTOR${Color_Off}: "
    read -p " " RF
elif [ "$OPTION" == "2" ]
then 
    printf "ENTER THE VALUE OF ${Purple}REPLICATION FACTOR${Color_Off}: "
    read -p " "RF
elif [ "$OPTION" == "3" ]
then
    printf "ENTER SPACE SEPARATED LIST OF ${Purple}KEYSPACES${Color_Off}: "
    read -p " " KEYSPACES
    printf "ENTER THE VALUE OF ${Purple}REPLICATION FACTOR${Color_Off}: "
    read -p " " RF
else 
    printf "INVALID INPUT"
    exit 1
fi

printf "ENTER THE ${Purple}REPLICATION STRATEGY${Color_Off}: "
read -p " " RFSTRATEGY
printf "ENTER THE ${Purple}DATACENTER NAME${Color_Off}: "
read -p " " DATACENTER


cqlsh $PRIVATEIP -e "describe keyspaces" > temp.txt

if [ "$OPTION" == "1" ]
then 
    while read line; do
        for word in $line; do
            if [ ${word:0:6} != "system" ]
            then 
                # echo "word = '$word'"
                printf "ALTER KEYSPACE $word WITH replication = { 'class' : '$RFSTRATEGY', '$DATACENTER' : $RF};\n" >> CQLcommands.cql
            fi
        done
    done <"temp.txt"
elif [ "$OPTION" == "2" ]
then
    while read line; do
        for word in $line; do
            if [ ${word:0:12} == "\"alternator_" ]
            then 
                # echo "word = '$word'"
                printf "ALTER KEYSPACE $word WITH replication = { 'class' : '$RFSTRATEGY', '$DATACENTER' : $RF};\n" >> CQLcommands.cql
            fi
        done
    done <"temp.txt"
else 
    for KEYSPACE in $KEYSPACES
        do
            printf "ALTER KEYSPACE $KEYSPACE WITH replication = { 'class' : '$RFSTRATEGY', '$DATACENTER' : $RF};\n" >> CQLcommands.cql
    done
fi

printf "Changing the replication factor, this might take a few minutes....\n"
cqlsh $PRIVATEIP --file CQLcommands.cql
printf "Done.. \n"
rm -f CQLcommands.cql
rm -f temp.txt