#docker build . -t owncloud
#
if [ -d "$HOME/prog8300" ] 
then
    echo "Directory $HOME/prog8300 exists. continuing." 
else
    mkdir $HOME/prog8300 
fi

ip route get 8.8.8.8 > /dev/null 2>&1
if [ $? -eq 0 ]
then
	echo "on routable IP network"
	export EXT_IP=$(ip route get 8.8.8.8 | awk -F"src " 'NR==1{split($2,a," ");print a[1]}')
else
	echo "on host-only network, using eth0 device for primary IP"
	export EXT_IP=$(ip route | grep eth0 | awk -F"src " 'NR==1{split($2,a," ");print a[1]}')
fi

docker run --name owncloud --detach   -e EXTERNAL_IP=$EXT_IP -v "$HOME/prog8300:/mnt/data/files:cached" -p 80:80 owncloud

