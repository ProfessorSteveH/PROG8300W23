#docker build --rm -t jupyter .
export OC_IP=$(docker inspect owncloud | jq '.[].NetworkSettings.Networks.bridge.IPAddress' | sed -e 's/^"//' -e 's/"$//')
docker run --name jupyter --detach --restart=always -e "OC_IP=$OC_IP" -e "OC_USER=admin" -e "OC_PASS=p@ssw0rd"  -p 8000:8000   jupyter
