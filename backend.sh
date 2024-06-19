#!/bin/bash
id=$(echo $UID)
TIMESTAMP=$(date +%F-%H-%M-%S)
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
LOG_FILE=/tmp/$SCRIPT_NAME-$TIMESTAMP.log
echo "script started time: $TIMESTAMP"
R="\e[31m"
G="\e[32m"
N="\e[0m"
Y="\e[33m"
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
dnf module disable nodejs -y &>>$LOG_FILE
VALIDATE $? "disabling the default nodejs"
dnf module enable nodejs:20 -y &>>$LOG_FILE
VALIDATE $? "enabling nodejs:20"
dnf install nodejs -y &>>$LOG_FILE
VALIDATE $? "install the node"
id expense &>>$LOG_FILE
if [ $? -ne 0 ]
then 
   useradd expense
   VALIDATE $? "to create the user"
 else 
  echo -e "user already created ....$Y SKIPPING $N"
fi 
mkdir -p /app
VALIDATE $? "to create apps directory"
     
