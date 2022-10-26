#!/bin/sh

INSTALLATION_FOLDER=$1

BOOL=1
while [ $BOOL -eq 1 ]; do
        echo
        # TODO FAZER O ENTER ENTRAR DIRETAMENTE COMO Y
        read -p 'ENABLE PROXYPORT? [y/n] : ' PROXY
        case "$PROXY" in
                Y)
                        sed -i '249 i [transport.https.properties]' $INSTALLATION_FOLDER/wso2am*/repository/conf/deployment.toml
                        sed -i '250 i proxyPort = 443\n' $INSTALLATION_FOLDER/wso2am*/repository/conf/deployment.toml
                        BOOL=0
                        ;;
                y)
                        sed -i '249 i [transport.https.properties]' $INSTALLATION_FOLDER/wso2am*/repository/conf/deployment.toml
                        sed -i '250 i proxyPort = 443\n' $INSTALLATION_FOLDER/wso2am*/repository/conf/deployment.toml
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
