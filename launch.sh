#!/bin/bash

export IMAGE_API_DB='eu.gcr.io/hutoma-oss/core/db:latest'
export IMAGE_LOG_FLUENT='eu.gcr.io/hutoma-oss/core/fluent:latest'
export IMAGE_API_CTRL='eu.gcr.io/hutoma-oss/core/api-ctrl:latest'
export IMAGE_API_SVC='eu.gcr.io/hutoma-oss/core/api-svc:latest'
export IMAGE_API_ENTITY='eu.gcr.io/hutoma-oss/core/entity-rec:latest'
export IMAGE_EMBEDDING='eu.gcr.io/hutoma-oss/core/embedding:latest'
export IMAGE_WEB_REVERSE_PROXY='eu.gcr.io/hutoma-oss/core/reverse-proxy:latest'
export IMAGE_WEB_CONSOLE='eu.gcr.io/hutoma-oss/core/web-console:latest'
export IMAGE_WEB_MEDIASERVER='eu.gcr.io/hutoma-oss/core/web-media:latest'
export IMAGE_WORD2VEC='eu.gcr.io/hutoma-oss/core/word2vec:latest'

./_launch_system.sh
