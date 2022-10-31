#!/bin/bash

pushd owncloud && docker rm owncloud && bash ./docker-start.sh && popd

pushd code-server && docker rm  code-server && bash ./docker-start.sh && popd

pushd jupyter && docker rm jupyter && bash ./docker-start.sh && popd




