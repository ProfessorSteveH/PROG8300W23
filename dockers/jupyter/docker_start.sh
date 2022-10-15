#docker build --rm -t jupyter2 .
docker run --name jupyter --detach --restart=always --mount source=jupyter_data,target=/home/steve/JupyterLab -p 8888:8888 jupyter
