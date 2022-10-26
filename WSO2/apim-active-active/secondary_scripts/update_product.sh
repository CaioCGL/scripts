#!/bin/sh

INSTALLATION_FOLDER=$1

BOOL=1
while [ $BOOL -eq 1 ]; do
        echo
        # TODO FAZER O ENTER ENTRAR DIRETAMENTE COMO Y
        read -p 'DO YOU WANT TO UPDATE THE PRODUCT? [y/n] : ' UPDATE
        case "$UPDATE" in
                Y)
                        cd $INSTALLATION_FOLDER/wso2am*/bin/
                        ./wso2update_linux
                        cd -
                        BOOL=0
                        ;;
                y)
                        cd $INSTALLATION_FOLDER/wso2am*/bin/
                        ./wso2update_linux
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




























