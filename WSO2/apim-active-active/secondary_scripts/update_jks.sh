#!/bin/sh

INSTALLATION_FOLDER=$1
JKSPATH=$2
PUBPATH=$3
REP_PASSWORD=$4

BOOL=1
while [ $BOOL -eq 1 ]; do
        echo
        # TODO FAZER O ENTER ENTRAR DIRETAMENTE COMO Y
        read -p 'DO YOU WANT TO UPDATE THE .JKS REPOSITORIES? [y/n] : ' UPDATE
        case "$UPDATE" in
                Y)
                        cd $INSTALLATION_FOLDER/wso2am*/repository/resources/security
                        read -p 'PLEASE TYPE THE wso2carbon.jks ABSOLUTE PATH: ' JKSPATH
                        mv $JKSPATH .
                        read -p 'PLEASE TYPE THE PUBLIC CERTIFICATE ABSOLUTE PATH: ' PUBPATH
                        read -p 'PLEASE TYPE THE REPOSITORY PASSWORD: ' REP_PASSWORD
                        keytool -delete -alias wso2carbon -keystore client-truststore.jks
                        keytool -import -alias wso2carbon -file $PUBPATH -keystore client-truststore.jks -storepass wso2carbon

                        # Comentando keystore.tls
                        sed -i '28,33d' $INSTALLATION_FOLDER/wso2am*/repository/conf/deployment.toml
                        sed -i '28 i #[keystore.tls]' $INSTALLATION_FOLDER/wso2am*/repository/conf/deployment.toml
                        sed -i '29 i #file_name =  "wso2carbon.jks"' $INSTALLATION_FOLDER/wso2am*/repository/conf/deployment.toml
                        sed -i '30 i #type =  "JKS"' $INSTALLATION_FOLDER/wso2am*/repository/conf/deployment.toml
                        sed -i '31 i #password =  "wso2carbon"' $INSTALLATION_FOLDER/wso2am*/repository/conf/deployment.toml
                        sed -i '32 i #alias =  "wso2carbon"' $INSTALLATION_FOLDER/wso2am*/repository/conf/deployment.toml
                        sed -i '33 i #key_password =  "wso2carbon"' $INSTALLATION_FOLDER/wso2am*/repository/conf/deployment.toml

                        # Descomentando keystore.primary
                        sed -i '38,43d' $INSTALLATION_FOLDER/wso2am*/repository/conf/deployment.toml
                        sed -i '38 i [keystore.primary]' $INSTALLATION_FOLDER/wso2am*/repository/conf/deployment.toml
                        sed -i '39 i file_name =  "wso2carbon.jks"' $INSTALLATION_FOLDER/wso2am*/repository/conf/deployment.toml
                        sed -i '40 i type =  "JKS"' $INSTALLATION_FOLDER/wso2am*/repository/conf/deployment.toml
                        sed -i '41 i password =  "'"$REP_PASSWORD"'"' $INSTALLATION_FOLDER/wso2am*/repository/conf/deployment.toml
                        sed -i '42 i alias =  "wso2carbon"' $INSTALLATION_FOLDER/wso2am*/repository/conf/deployment.toml
                        sed -i '43 i key_password =  "'"$REP_PASSWORD"'"' $INSTALLATION_FOLDER/wso2am*/repository/conf/deployment.toml

                        cd -
                        BOOL=0
                        ;;
                y)
                        cd $INSTALLATION_FOLDER/wso2am*/repository/resources/security
                        read -p 'PLEASE TYPE THE wso2carbon.jks ABSOLUTE PATH: ' JKSPATH
                        mv $JKSPATH .
                        read -p 'PLEASE TYPE THE PUBLIC CERTIFICATE ABSOLUTE PATH: ' PUBPATH
                        read -p 'PLEASE TYPE THE REPOSITORY PASSWORD: ' REP_PASSWORD
                        keytool -delete -alias wso2carbon -keystore client-truststore.jks
                        keytool -import -alias wso2carbon -file $PUBPATH -keystore client-truststore.jks -storepass wso2carbon

                        # Comentando keystore.tls
                        sed -i '28,33d' $INSTALLATION_FOLDER/wso2am*/repository/conf/deployment.toml
                        sed -i '28 i #[keystore.tls]' $INSTALLATION_FOLDER/wso2am*/repository/conf/deployment.toml
                        sed -i '29 i #file_name =  "wso2carbon.jks"' $INSTALLATION_FOLDER/wso2am*/repository/conf/deployment.toml
                        sed -i '30 i #type =  "JKS"' $INSTALLATION_FOLDER/wso2am*/repository/conf/deployment.toml
                        sed -i '31 i #password =  "wso2carbon"' $INSTALLATION_FOLDER/wso2am*/repository/conf/deployment.toml
                        sed -i '32 i #alias =  "wso2carbon"' $INSTALLATION_FOLDER/wso2am*/repository/conf/deployment.toml
                        sed -i '33 i #key_password =  "wso2carbon"' $INSTALLATION_FOLDER/wso2am*/repository/conf/deployment.toml

                        # Descomentando keystore.primary
                        sed -i '38,43d' $INSTALLATION_FOLDER/wso2am*/repository/conf/deployment.toml
                        sed -i '38 i [keystore.primary]' $INSTALLATION_FOLDER/wso2am*/repository/conf/deployment.toml
                        sed -i '39 i file_name =  "wso2carbon.jks"' $INSTALLATION_FOLDER/wso2am*/repository/conf/deployment.toml
                        sed -i '40 i type =  "JKS"' $INSTALLATION_FOLDER/wso2am*/repository/conf/deployment.toml
                        sed -i '41 i password =  "'"$REP_PASSWORD"'"' $INSTALLATION_FOLDER/wso2am*/repository/conf/deployment.toml
                        sed -i '42 i alias =  "wso2carbon"' $INSTALLATION_FOLDER/wso2am*/repository/conf/deployment.toml
                        sed -i '43 i key_password =  "'"$REP_PASSWORD"'"' $INSTALLATION_FOLDER/wso2am*/repository/conf/deployment.toml
                        cd -
                        BOOL=0
                        ;;
                N)
                        BOOL=0
                        ;;
                n)
                        BOOL=0
                        ;;
                *)
                        echo "INVALID INPUT."
                        ;;
        esac
done
