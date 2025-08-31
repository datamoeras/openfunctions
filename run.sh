#!/bin/bash

id=1234 ./build.sh -b
docker run --rm -p 8082:80 -e AzureWebJobsStorage='DefaultEndpointsProtocol=http;AccountName=account1;AccountKey=key1;BlobEndpoint=http://account1.blob.localhost:10000;QueueEndpoint=http://account1.queue.localhost:10001;TableEndpoint=http://account1.table.localhost:10002;' -it openfunc:1234
# curl -v http://127.0.01:8082/api/HttpExample

