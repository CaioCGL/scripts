#!/bin/sh

# EDIÇÃO DO DEPLOYMENT.TOML (CONFIG DE HA)

INSTALLATION_FOLDER=$1
HOSTNAME=$2
GW_URL=$3
NODE1=$4
NODE2=$5

# [[apim.gateway.environment]]
sed -i '59d' $INSTALLATION_FOLDER/wso2am*/repository/conf/deployment.toml
sed -i '59 i service_url = "https://'"$GW_URL"':${mgt.transport.https.port}/services/"' $INSTALLATION_FOLDER/wso2am*/repository/conf/deployment.toml
sed -i '62,63d' $INSTALLATION_FOLDER/wso2am*/repository/conf/deployment.toml
sed -i '62 i #ws_endpoint = "ws://localhost:9099"' $INSTALLATION_FOLDER/wso2am*/repository/conf/deployment.toml
sed -i '63 i #wss_endpoint = "wss://localhost:8099"' $INSTALLATION_FOLDER/wso2am*/repository/conf/deployment.toml
sed -i '64,65d' $INSTALLATION_FOLDER/wso2am*/repository/conf/deployment.toml
sed -i '64 i http_endpoint = "http://'"$GW_URL"':8280"' $INSTALLATION_FOLDER/wso2am*/repository/conf/deployment.toml
sed -i '65 i https_endpoint = "https://'"$GW_URL"':8243"' $INSTALLATION_FOLDER/wso2am*/repository/conf/deployment.toml
sed -i '66,67d' $INSTALLATION_FOLDER/wso2am*/repository/conf/deployment.toml
sed -i '66 i #websub_event_receiver_http_endpoint = "http://localhost:9021"' $INSTALLATION_FOLDER/wso2am*/repository/conf/deployment.toml
sed -i '67 i #websub_event_receiver_https_endpoint = "https://localhost:8021"' $INSTALLATION_FOLDER/wso2am*/repository/conf/deployment.toml

# [apim.idp]
sed -i '114,118d' $INSTALLATION_FOLDER/wso2am*/repository/conf/deployment.toml
sed -i '114 i [apim.idp]' $INSTALLATION_FOLDER/wso2am*/repository/conf/deployment.toml
sed -i '115 i server_url = "https://'"$HOSTNAME"':${mgt.transport.https.port}"' $INSTALLATION_FOLDER/wso2am*/repository/conf/deployment.toml
sed -i '116 i authorize_endpoint = "https://'"$HOSTNAME"':${mgt.transport.https.port}/oauth2/authorize"' $INSTALLATION_FOLDER/wso2am*/repository/conf/deployment.toml
sed -i '117 i oidc_logout_endpoint = "https://'"$HOSTNAME"':${mgt.transport.https.port}/oidc/logout"' $INSTALLATION_FOLDER/wso2am*/repository/conf/deployment.toml
sed -i '118 i oidc_check_session_endpoint = "https://'"$HOSTNAME"':${mgt.transport.https.port}/oidc/checksession"' $INSTALLATION_FOLDER/wso2am*/repository/conf/deployment.toml

# [apim.jwt]
sed -i '120,129d' $INSTALLATION_FOLDER/wso2am*/repository/conf/deployment.toml
sed -i '120 i [apim.jwt]' $INSTALLATION_FOLDER/wso2am*/repository/conf/deployment.toml
sed -i '121 i enable = true' $INSTALLATION_FOLDER/wso2am*/repository/conf/deployment.toml
sed -i '122 i encoding = "base64" # base64,base64url' $INSTALLATION_FOLDER/wso2am*/repository/conf/deployment.toml
sed -i '123 i generator_impl = "org.wso2.carbon.apimgt.keymgt.token.JWTGenerator"' $INSTALLATION_FOLDER/wso2am*/repository/conf/deployment.toml
sed -i '124 i claim_dialect = "http://wso2.org/claims"' $INSTALLATION_FOLDER/wso2am*/repository/conf/deployment.toml
sed -i '125 i convert_dialect = false' $INSTALLATION_FOLDER/wso2am*/repository/conf/deployment.toml
sed -i '126 i header = "X-JWT-Assertion"' $INSTALLATION_FOLDER/wso2am*/repository/conf/deployment.toml
sed -i '127 i signing_algorithm = "SHA256withRSA"' $INSTALLATION_FOLDER/wso2am*/repository/conf/deployment.toml
sed -i '128 i enable_user_claims = true' $INSTALLATION_FOLDER/wso2am*/repository/conf/deployment.toml
sed -i '129 i claims_extractor_impl = "org.wso2.carbon.apimgt.impl.token.ExtendedDefaultClaimsRetriever"' $INSTALLATION_FOLDER/wso2am*/repository/conf/deployment.toml

# [apim.oauth_config]
sed -i '131,134d' $INSTALLATION_FOLDER/wso2am*/repository/conf/deployment.toml
sed -i '131 i [apim.oauth_config]' $INSTALLATION_FOLDER/wso2am*/repository/conf/deployment.toml
sed -i '132 i #enable_outbound_auth_header = true' $INSTALLATION_FOLDER/wso2am*/repository/conf/deployment.toml
sed -i '133 i auth_header = "Authorization"' $INSTALLATION_FOLDER/wso2am*/repository/conf/deployment.toml
sed -i '134 i revoke_endpoint = "https://'"$HOSTNAME"':${https.nio.port}/revoke"' $INSTALLATION_FOLDER/wso2am*/repository/conf/deployment.toml
sed -i '135 i token_endpoint = "https://'"$HOSTNAME"':${https.nio.port}/token"' $INSTALLATION_FOLDER/wso2am*/repository/conf/deployment.toml

# [apim.devportal]
sed -i '139,140d' $INSTALLATION_FOLDER/wso2am*/repository/conf/deployment.toml
sed -i '139 i [apim.devportal]' $INSTALLATION_FOLDER/wso2am*/repository/conf/deployment.toml
sed -i '140 i url = "https://'"$HOSTNAME"':9443/devportal"' $INSTALLATION_FOLDER/wso2am*/repository/conf/deployment.toml

# [[event_listener.properties]]
sed -i '252d' $INSTALLATION_FOLDER/wso2am*/repository/conf/deployment.toml
sed -i '252 i notification_endpoint = "https://'"$HOSTNAME"':${mgt.transport.https.port}/internal/data/v1/notify"' $INSTALLATION_FOLDER/wso2am*/repository/conf/deployment.toml

# ALTA DISPONIBILIDADE
sed -i '236 i [apim.throttling]' $INSTALLATION_FOLDER/wso2am*/repository/conf/deployment.toml
sed -i '237 i event_duplicate_url = ["tcp://'"$NODE2"':5672"]\n' $INSTALLATION_FOLDER/wso2am*/repository/conf/deployment.toml
sed -i '239 i [[apim.throttling.url_group]]' $INSTALLATION_FOLDER/wso2am*/repository/conf/deployment.toml
sed -i '240 i traffic_manager_urls = ["tcp://'"$NODE1"':9611"]' $INSTALLATION_FOLDER/wso2am*/repository/conf/deployment.toml
sed -i '241 i traffic_manager_auth_urls = ["ssl://'"$NODE1"':9711"]' $INSTALLATION_FOLDER/wso2am*/repository/conf/deployment.toml
sed -i '242 i type = "loadbalance"\n' $INSTALLATION_FOLDER/wso2am*/repository/conf/deployment.toml
sed -i '244 i [[apim.throttling.url_group]]' $INSTALLATION_FOLDER/wso2am*/repository/conf/deployment.toml
sed -i '245 i traffic_manager_urls = ["tcp://'"$NODE2"':9611"]' $INSTALLATION_FOLDER/wso2am*/repository/conf/deployment.toml
sed -i '246 i traffic_manager_auth_urls = ["ssl://'"$NODE2"':9711"]' $INSTALLATION_FOLDER/wso2am*/repository/conf/deployment.toml
sed -i '247 i type = "loadbalance"\n' $INSTALLATION_FOLDER/wso2am*/repository/conf/deployment.toml
