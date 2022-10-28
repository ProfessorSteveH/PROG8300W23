#!/bin/bash

set -m

bash /usr/local/bin/owncloud_loop.sh &

code-server --bind-addr 0.0.0.0:8001
