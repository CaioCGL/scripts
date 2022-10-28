#!/bin/sh

# OBS: Before run this script, make sure the wso2am-4.1.0.zip file is inside this directory.

echo
echo "STARTING WSO2 API MANAGER ACTIVE-ACTIVE INSTALLATION..."
echo

echo "PLEASE TYPE THE INSTALLATION FOLDER: "
read INSTALLATION_FOLDER
echo 

echo "PLEASE TYPE THE HOSTNAME: "
read HOSTNAME
sed -i '2d' $INSTALLATION_FOLDER/wso2am*/repository/conf/deployment.toml
sed -i '2 i hostname = "'"$HOSTNAME"'"' $INSTALLATION_FOLDER/wso2am*/repository/conf/deployment.toml

echo "PLEASE TYPE THE GATEWAY URL: "
read GW_URL

echo "PLEASE TYPE THE NODE 1 HOSTNAME: "
read NODE1

echo "PLEASE TYPE THE NODE 2 HOSTNAME: "
read NODE2

echo "PLEASE TYPE THE NODE 2 USERNAME: "
read N2_USER

# TODO VERIFICAR SE TEM O ZIP/UNZIP INSTALADO
echo | sudo apt install zip unzip -y

# TODO IMPLEMENTAR VERIFICAÇÃO DE PERMISSÕES DA PASTA DESTINO
unzip ./wso2am*.zip -d $INSTALLATION_FOLDER

cd ./secondary_scripts

./update_product.sh $INSTALLATION_FOLDER

./deployment_conf.sh $INSTALLATION_FOLDER $HOSTNAME $GW_URL $NODE1 $NODE2

./enable_proxyport.sh $INSTALLATION_FOLDER

./update_jks.sh $INSTALLATION_FOLDER $JKSPATH $PUBPATH $REP_PASSWORD

BOOL=1
while [ $BOOL -eq 1 ]; do
	echo
  	# TODO FAZER O ENTER ENTRAR DIRETAMENTE COMO Y
  	read -p 'DO YOU WANT TO CONFIGURE EXTERNAL DATABASE (MYSQL 5.7 ONLY) ? [y/n] : ' UPDATE
        case "$UPDATE" in
        	Y)
			./conf_database.sh $INSTALLATION_FOLDER
			DATABASE=1
			BOOL=0
			;;
		y)
			./conf_database.sh $INSTALLATION_FOLDER
                        DATABASE=1
			BOOL=0
                        ;;
		N)	
			BOOL=0
			DATABASE=0
			;;
		n)
			BOOL=0
			DATABASE=0
			;;
		*)
			echo "INVALID INPUT."
			;;
		esac
done
			
# PREPARAÇÃO DO NODE 2
mkdir /tmp/n2
cp -r $INSTALLATION_FOLDER/wso2am*/ /tmp/n2/
if [ $DATABASE -eq 1 ]; then
	sed -i '239d' /tmp/n2/wso2am*/repository/conf/deployment.toml
	sed -i '239 i event_duplicate_url = ["tcp://'"$NODE1"':5672"]' /tmp/n2/wso2am*/repository/conf/deployment.toml
else
	sed -i '237d' /tmp/n2/wso2am*/repository/conf/deployment.toml
       	sed -i '237 i event_duplicate_url = ["tcp://'"$NODE1"':5672"]' /tmp/n2/wso2am*/repository/conf/deployment.toml
fi
		
tar -czf /tmp/n2/wso2am_n2.tar.gz /tmp/n2/wso2am*
scp /tmp/n2/wso2am*.zip $N2_USER@$NODE2:/tmp/


rm -r /tmp/n2

cd ..

