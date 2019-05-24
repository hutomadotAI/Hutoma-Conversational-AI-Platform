#!/bin/bash

SERVER_NAME=www.example.com
CODE_LOCATION=$(pwd)/source


# Clone all the required repos
git clone https://github.com/hutomadotAI/entity_recogniser.git $CODE_LOCATION/entity_recogniser
git clone https://github.com/hutomadotAI/qamatcher.git $CODE_LOCATION/qamatcher
git clone https://github.com/hutomadotAI/word2vec.git $CODE_LOCATION/word2vec
git clone https://github.com/hutomadotAI/web-api.git $CODE_LOCATION/web-api
git clone https://github.com/hutomadotAI/web-console.git $CODE_LOCATION/web-console

pushd .

# Build the API Java components
cd $CODE_LOCATION/web-api/service
mvn package -DskipTests -Dfindbugs.skip=true -Dcheckstyle.skip -Djacoco.skip=true -Denunciate.skip=true -Ddependency-check.skip=true


# Build all the Docker images
cd $CODE_LOCATION/entity_recogniser/src
docker build -t hu_er .
cd $CODE_LOCATION/qamatcher/src
docker build -t hu_qamatcher .
cd $CODE_LOCATION/word2vec/src
docker build -t hu_word2vec .

cd $CODE_LOCATION/web-api/db
docker build -t hu_api-db .
cd $CODE_LOCATION/web-api/service/controller-service
docker build -t hu_api-controller .
cd $CODE_LOCATION/web-api/service/core-service
docker build -t hu_api-core .

cd $CODE_LOCATION/web-console/src
docker build --build-arg ENVIRONMENT=production -t hu_web-console .
cd $CODE_LOCATION/web-console/mediaserver
docker build -t hu_media-server .

popd

# Build the reverse proxy
cd $(pwd)/reverse_proxy
docker build -t hu_reverse-proxy .


