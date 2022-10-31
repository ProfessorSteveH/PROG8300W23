#$ docker build . -t code-server
export OC_IP=$(docker inspect owncloud | jq '.[].NetworkSettings.Networks.bridge.IPAddress' | sed -e 's/^"//' -e 's/"$//')
docker run --name code-server --detach  -e "OC_IP=$OC_IP" -e "OC_USER=admin" -e "OC_PASS=p@ssw0rd"  -p 8001:8001   code-server:latest
