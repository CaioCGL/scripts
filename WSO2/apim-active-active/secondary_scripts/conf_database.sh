#!/bin/sh

INSTALLATION_FOLDER=$1

echo "DOWNLOADING MYSQL JAVA CONNECTOR..."
MYSQL_CONNECTOR_VERSION=8.0.17
cd /tmp
wget https://repo1.maven.org/maven2/mysql/mysql-connector-java/${MYSQL_CONNECTOR_VERSION}/mysql-connector-java-${MYSQL_CONNECTOR_VERSION}.jar
mv mysql-connector*.jar $INSTALLATION_FOLDER/wso2am*/repository/components/dropins/
cd -
read -p "PLEASE TYPE THE DATABASE HOSTNAME/IP ADDRESS :" DATABASE_HOSTNAME
read -p "PLEASE TYPE THE DATABASE CONNECTION PORT :" DATABASE_PORT
read -p "PLEASE TYPE THE SHARED_DB NAME :" DATABASE_SHARED_DB
read -p "PLEASE TYPE THE APIM_DB NAME :" DATABASE_APIM_DB
read -p "PLEASE TYPE THE DATABASE ADMIN USERNAME :" DATABASE_USERNAME
echo $DATABASE_USERNAME
read -p "PLEASE TYPE THE DATABASE ADMIN PASSWORD :" DATABASE_PASSWORD
sed -i '16,26d' $INSTALLATION_FOLDER/wso2am*/repository/conf/deployment.toml
sed -i '16 i [database.apim_db]' $INSTALLATION_FOLDER/wso2am*/repository/conf/deployment.toml
sed -i '17 i type = "mysql"' $INSTALLATION_FOLDER/wso2am*/repository/conf/deployment.toml
sed -i '18 i url = "jadbc:mysql://'"$DATABASE_HOSTNAME"':'"$DATABASE_PORT"'/'"$DATABASE_APIM_DB"'?autoReconnect=true&amp;useSSL=false"' $INSTALLATION_FOLDER/wso2am*/repository/conf/deployment.toml
sed -i '19 i username = "'"$DATABASE_USERNAME"'"' $INSTALLATION_FOLDER/wso2am*/repository/conf/deployment.toml
sed -i '20 i password = "'"$DATABASE_PASSWORD"'"' $INSTALLATION_FOLDER/wso2am*/repository/conf/deployment.toml
sed -i '21 i driver = "com.mysql.cj.jdbc.Driver"\n' $INSTALLATION_FOLDER/wso2am*/repository/conf/deployment.toml
sed -i '23 i [database.shared_db]' $INSTALLATION_FOLDER/wso2am*/repository/conf/deployment.toml
sed -i '24 i type = "mysql"' $INSTALLATION_FOLDER/wso2am*/repository/conf/deployment.toml
sed -i '25 i url = "jdbc:mysql://'"$DATABASE_HOSTNAME"':'"$DATABASE_PORT"'/'"$DATABASE_SHARED_DB"'?autoReconnect=true&amp;useSSL=false"' $INSTALLATION_FOLDER/wso2am*/repository/conf/deployment.toml
sed -i '26 i username = "'"$DATABASE_USERNAME"'"' $INSTALLATION_FOLDER/wso2am*/repository/conf/deployment.toml
sed -i '27 i password = "'"$DATABASE_PASSWORD"'"' $INSTALLATION_FOLDER/wso2am*/repository/conf/deployment.toml
sed -i '28 i driver = "com.mysql.cj.jdbc.Driver"' $INSTALLATION_FOLDER/wso2am*/repository/conf/deployment.toml
cd -
