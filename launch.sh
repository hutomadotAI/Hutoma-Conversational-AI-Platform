#!/bin/bash

export IMAGE_API_DB='eu.gcr.io/hutoma-oss/core/db'
export IMAGE_LOG_FLUENT='eu.gcr.io/hutoma-oss/core/fluent'
export IMAGE_API_CTRL='eu.gcr.io/hutoma-oss/core/api-ctrl'
export IMAGE_API_SVC='eu.gcr.io/hutoma-oss/core/api-svc'
export IMAGE_API_ENTITY='eu.gcr.io/hutoma-oss/core/entity-rec'
export IMAGE_EMBEDDING='eu.gcr.io/hutoma-oss/core/embedding'
export IMAGE_WEB_REVERSE_PROXY='eu.gcr.io/hutoma-oss/core/reverse-proxy'
export IMAGE_WEB_CONSOLE='eu.gcr.io/hutoma-oss/core/web-console'
export IMAGE_WEB_MEDIASERVER='eu.gcr.io/hutoma-oss/core/web-media'
export IMAGE_WORD2VEC='eu.gcr.io/hutoma-oss/core/word2vec'

./_launch_system.sh