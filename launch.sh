#!/bin/bash

# Define whether to use a local Word2Vec service or istead use the public one
USE_LOCAL_W2V=false

# Define which languages to support by the system
declare -a languages_array=("en" "es" "it")
# Define the Word2Vec files to use for each language
languages_w2v_files=",en:glove.840B.300d.pkl,es:wiki.es.pkl,it:wiki.it.pkl,"


get_w2vfile_for_lang() {
    echo "$(expr "$languages_w2v_files" : ".*,$1:\([^,]*\),.*")"
}


# Delete the docker compose file since we're going to re-generate it
DOCKER_COMPOSE="docker-compose.yml"
if test -f "$DOCKER_COMPOSE" ]; then
    rm $DOCKER_COMPOSE
fi

cat docker-compose_template.yml > docker-compose.yml

for language in "${languages_array[@]}"
do
    if $USE_LOCAL_W2V; then
        
        w2vfile="$(get_w2vfile_for_lang $language)"
        #
        # If using a local Word2Vec service, need to make sure the glove pickle is
        # available locally so that the container can mount the file
        #
        if [ ! -f $w2vfile ]; then
            echo Downloading Word2Vec file for language $language - $w2vfile...
            gsutil cp gs://hutoma-datasets/word2vec_service/v2/$w2vfile $w2vfile
        fi

        # Include the service in the compose file
        sed -e "s/{WORD2VEC_FILE_SUBST}/$w2vfile/g" -e "s/{LANG_SUBST}/$language/g" w2v_service.yml >> docker-compose.yml
        # And update the references from the external service to the local one
        sed -e "s/{LANG_SUBST}/$language/g" -e "s#{W2V_SERVER_URL}#http://ai-word2vec-$language:9090#g" emb_service.yml >> docker-compose.yml

    else

        # Use the public Word2Vec service for the given language
        sed -e "s/{LANG_SUBST}/$language/g" -e "s#{W2V_SERVER_URL}#https://word2vec-$language.hutoma.ai#g" emb_service.yml >> docker-compose.yml
    fi

done



#
# Container images
#
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



# Required for launching the system without the console
export API_ENCODING_KEY='L0562EMBfnLadKy57nxo9btyi3BEKm9m+DoNvGcfZa+DjHsXwTl+BwCE4NeKEAagfkhYBFvhvJoAgtugSsQOfw=='
export API_DB_HUTOMA_CALLER_PASSWORD='%3EYR%22khuN*.gF)V4%23'

# Required only by the console
export API_DB_DJANGO_CALLER_PASSWORD='L#B7d*8S3Dbv3'
export DJANGO_SECRET_KEY='eXozKis4dHkmbyp6eGMjPXB2aWVjNWE0KTdzYm1lJjJybGZuayNvYmF1Y2FfbzF3OGQ='
export DJANGO_LEGACY_SALT='XiMkOSUxZisyXnA5KWFAODkpViQ='
export REDIS_SERVICE_PASSWORD='eXozKis4dHkmbyp6eGMjPXB2aWVjNWE0KTdzYm1lJjJybGZuayNvYmF1Y2FfbzF3OGQ'

export DJANGO_ALLOWED_HOSTS='["*"]'
export WHITELISTED_EMAIL_DOMAINS='["hutoma.com", "hutoma.ai", "gmail.com", "sharklasers.com", "mailinator.com"]'
export CONSOLE_SERVICE='ai.hutoma.console.dev'
export WEB_MEDIASERVER_URL=https://localhost:8443/media
export DJANGO_STATIC_HOST=https://localhost:8443
export API_ADMIN_DEVTOKEN='eyJhbGciOiJIUzI1NiIsImNhbGciOiJERUYifQ.eNqqVgry93FVsgJT8Y4uvp5-SjpKxaVJQKHElNzMPKVaAAAAAP__.e-INR1D-L_sokTh9sZ9cBnImWI0n6yXXpDCmat1ca_c'
# For Facebook integration
export FACEBOOK_APP_ID=
export FACEBOOK_APP_SECRET=
# SMTP2GO configuration, to allow registration of new users and password reset emails
export EMAIL_HOST_USER=
export EMAIL_HOST_PASSWORD=
# Google Re-Captcha public and private keys required for signin-in new users
export DJANGO_RECAPTCHA_PUBLIC_KEY=
export DJANGO_RECAPTCHA_PRIVATE_KEY=



docker-compose -p hutoma-oss up