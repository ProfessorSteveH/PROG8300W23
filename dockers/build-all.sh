#!/bin/bash

pushd owncloud && docker build . -t owncloud && bash ./docker-start.sh && popd

pushd code-server && docker build . -t code-server && bash ./docker-start.sh && popd

pushd jupyter && docker build . -t jupyter && bash ./docker-start.sh && popd




