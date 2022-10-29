

cd owncloud && docker build . -t owncloud

cd owncloud && bash ./docker-start.sh


cd code-server && docker build . -t code-server

cd code-server && bash ./docker-start.sh


cd jupyter && docker build . -t jupyter

cd jupyter && bash ./docker-start.sh


