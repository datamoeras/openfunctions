#!/bin/bash

id=1234 ./build.sh -b
docker run --rm -p 8082:80 -it openfunc:1234
# curl -v http://127.0.01:8082/api/HttpExample

