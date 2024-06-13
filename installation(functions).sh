#!/bin/bash
echo "file name is: " $0
id=`echo $UID`
if [ id -ne 0 ]
then 
  echo "not a root user"
  exit 1
else 
  echo "root user"
fi 
VALIDATE () {
    if [ $1 -ne 0 ]
    then 
      echo "$2 installation.....FAILURE"
    else 
      echo "$2 installation .....SUCCESS"  
   fi 
}

dnf install nginx -y 
VALIDATE $? "nginx"
