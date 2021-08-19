################################ FULL BACKUP################################

#!/bin/bash
 
################################################################
##
##   MySQL Database Backup Script 
##   Written By: BA Mouhamadou Moustapha
##
################################################################
 
export PATH=/bin:/usr/bin:/usr/local/bin
TODAY=`date +"%d%b%Y"`
 
################################################################
################## Update below values  ########################
 
DB_BACKUP_PATH='/backup/dbbackup'
MYSQL_HOST='localhost'
MYSQL_PORT='3306'
MYSQL_USER='root'
MYSQL_PASSWORD='mysecret'
DATABASE_NAME='mydb'
BACKUP_RETAIN_DAYS=30   ## Number of days to keep local backup copy
 
#################################################################
 
mkdir -p ${DB_BACKUP_PATH}/${TODAY}
echo "Backup started for database - ${DATABASE_NAME}"
 
 
mysqldump -h ${MYSQL_HOST} \
   -P ${MYSQL_PORT} \
   -u ${MYSQL_USER} \
   -p${MYSQL_PASSWORD} \
   ${DATABASE_NAME} | gzip > ${DB_BACKUP_PATH}/${TODAY}/${DATABASE_NAME}-${TODAY}.sql.gz
 
if [ $? -eq 0 ]; then
  echo "Database backup successfully completed"
else
  echo "Error found during backup"
  exit 1
fi
 
 
##### Remove backups older than {BACKUP_RETAIN_DAYS} days  #####
 
DBDELDATE=`date +"%d%b%Y" --date="${BACKUP_RETAIN_DAYS} days ago"`
 
if [ ! -z ${DB_BACKUP_PATH} ]; then
      cd ${DB_BACKUP_PATH}
      if [ ! -z ${DBDELDATE} ] && [ -d ${DBDELDATE} ]; then
            rm -rf ${DBDELDATE}
      fi
fi


#################Teste de ping sur une machine étrangère########################
i=0
while [ $i -ne 50 ] ; do 
  ping $HOST -c $TIMES -i $WAITFOR &> /dev/null
   pingReturn=$?


   if[$pingReturn -eq 0]; then
         # Si la machine est joignale
         echo "La machine est joignable avec succes!!!"
         scp ${TODAY}.sql.gz root@IP-Address:/home/root
         exit 0
       else
          # Si la machine est injoignable
          echo "La machine est injoignable" | mail -s "Machine Down" myadress@xxxx.com
          exit 1
   fi

  i=$(($i + 1))
done

###################################ANSIBLE#########################################

sudo apt-get update
sudo apt-get -y install nginx
sudo cp /etc/nginx/sites-available/default nginx.conf
sed -i -e '/^\s*#.*$/d' -e '/^\s*$/d' nginx.conf
sudo sed -i 's/root \/var\/www\/html\;/root \/usr\/share\/nginx\/html\;/g' nginx.conf
sudo cp nginx.conf /etc/nginx/sites-available/default
cat << EOF > index.html
<html><head><title>Debian Ubuntu Nginx Installation</title></head>
<body><h1>Nginx Installed</h1><p>If you can see this, nginx is successfully installed.</p></body></html>
EOF
sudo cp index.html /usr/share/nginx/html/index.html
sudo chmod 644 /usr/share/nginx/html/index.html
sudo systemctl restart nginx
sudo apt -y install curl
curl http://localhost

sudo useradd wordly
sudo mkhomedir_helper wordly
cd /home/wordly
echo 'Hello, world.' > wordly.txt



 
### End of script ####


