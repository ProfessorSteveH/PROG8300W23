#docker build --rm -t jupyter2 .
export OC_IP=$(docker inspect owncloud | jq '.[].NetworkSettings.Networks.bridge.IPAddress' | sed -e 's/^"//' -e 's/"$//')
docker run --name jupyter --detach --restart=always -e "OC_IP=$OC_IP" -e "OC_USER=admin" -e "OC_PASS=admin"  --mount source=jupyter_data,target=/home/steve/JupyterLab -p 8888:8888 jupyter
