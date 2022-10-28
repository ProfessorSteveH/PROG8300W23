#$ docker build . -t code-server
mkdir $HOME/Shared
export OC_IP=$(docker inspect owncloud | jq '.[].NetworkSettings.Networks.bridge.IPAddress' | sed -e 's/^"//' -e 's/"$//')
docker run --detach --restart=always -e "OC_IP=$OC_IP" -e "OC_USER=admin" -e "OC_PASS=admin"  -p 8001:8001  -v "$HOME/Shared:/shared:cached"  code-server:latest
