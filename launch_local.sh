#!/bin/bash

export IMAGE_API_DB='hu_api-db'
export IMAGE_LOG_FLUENT='fluent/fluentd:v1.1.1-onbuild'
export IMAGE_API_CTRL='hu_api-controller'
export IMAGE_API_SVC='hu_api-core'
export IMAGE_API_ENTITY='hu_er'
export IMAGE_EMBEDDING='hu_qamatcher'
export IMAGE_WEB_REVERSE_PROXY='hu_reverse-proxy'
export IMAGE_WEB_CONSOLE='hu_web-console'
export IMAGE_WEB_MEDIASERVER='hu_media-server'
export IMAGE_WORD2VEC='hu_word2vec'

./_launch_system.sh