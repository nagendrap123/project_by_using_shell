#!/bin/bash
id=$(echo $UID)
TIMESTAMP=$(date +%F-%H-%M-%S)
SCRIPT_NAME=$($0 | cut -d "." -f1)
LOG_FILE=/tmp/$SCRIPT_NAME-$TIMESTAMP.log
if [ $id -ne 0 ] 
then 
  echo "not a root user"
else 
  echo "root user"
fi 
VALIDATE () {
    if [ $1 -ne 0 ]
    then 
      echo "$2 ...installed..FAILURE"
    else 
      echo "$2 ...installed..SUCCESS"
    fi  
}    

dnf install mysql -y &>>$LOG_FILE
VALIDATE $? "mysql"
dnf install nginx -y &>>$LOG_FILE
VALIDATE $? "nginx"
