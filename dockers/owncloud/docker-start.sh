#docker build . -t owncloud
#
if [ -d "$HOME/prog8300" ] 
then
    echo "Directory $HOME/prog8300 exists. continuing." 
else
    mkdir $HOME/prog8300 
fi

export EXT_IP=$(ip route get 8.8.8.8 | awk -F"src " 'NR==1{split($2,a," ");print a[1]}')
docker run --name owncloud --detach   -e EXTERNAL_IP=$EXT_IP -v "$HOME/prog8300:/mnt/data/files:cached" -p 80:80 owncloud

