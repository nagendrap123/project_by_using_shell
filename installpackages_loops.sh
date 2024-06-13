#!/bin/bash
id=$(echo $UID)
TIMESTAMP=$(date +%F-%H-%M-%S)
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
LOG_FILE=/tmp/$SCRIPT_NAME-$TIMESTAMP.log
echo "script started time: $TIMESTAMP"
R="\e[31m"
G="\e[32m"
N="\e[0m"
if [ $id -ne 0 ] 
then 
  echo "not a root user"
else 
  echo "root user"
fi 
VALIDATE () {
    if [ $1 -ne 0 ]
    then 
      echo -e "$2 ...installed.. $R FAILURE $N"
    else 
      echo -e "$2 ...installed..$G SUCCESS $N"
    fi  
}    

for i in $@
do 
 echo "package to istall: $i"
 dnf list installed $i &>>LOG_FILE
 if [ $? -eq 0] 
 then 
   echo -e "already installed $i .....$G SKIPPING $N"
 else 
   dnf install $i -y &>>LOG_FILE
   VALIDATE $? "installation of $i"
 fi 
done 
 

