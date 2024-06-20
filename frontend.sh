#!/bin/bash
#using backend
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
dnf install nginx -y &>>$LOG_FILE
VALIDATE $? "install the nginx"
systemctl enable nginx  &>>$LOG_FILE
VALIDATE $? "enabling the nginx"
systemctl start nginx &>>$LOG_FILE
VALIDATE $? "enabling the nginx"
rm -rf /usr/share/nginx/html/* &>>$LOG_FILE
VALIDATE $? "removing the existing content"
curl -o /tmp/frontend.zip https://expense-builds.s3.us-east-1.amazonaws.com/expense-frontend-v2.zip &>>$LOG_FILE
VALIDATE $? "download the frontend content"
cd /usr/share/nginx/html
unzip /tmp/frontend.zip &>>$LOG_FILE
VALIDATE $? "unzip the frontend code"
cp /home/ec2-user/project_by_using_shell/expense.conf /etc/nginx/default.d/expense.conf &>>$LOG_FILE
VALIDATE $? "copy the expense.conf file"
systemctl restart nginx &>>$LOG_FILE
VALIDATE $? "restarting the nginx"
