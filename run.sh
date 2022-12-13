#!/usr/bin/env bash

mvn clean package

docker run \
    --detach \
    --name vespa \
    --publish 8080:8080 --publish 19071:19071 \
    vespaengine/vespa

vespa config set target local
vespa status deploy --wait 300
vespa deploy --wait 300

echo "check out http://localhost:8080/search/?yql=select+*+from+foo+where+true"