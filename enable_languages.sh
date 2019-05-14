#!/bin/bash

DB_USER=root
DB_PASSWORD=password
DB_IMAGE='hutoma-oss_api-db_1'

# English is already built-in, so no need to activate it as it's always enabled
#docker exec -it slim_api-db_1 /usr/bin/mysql -h localhost -u$DB_USER -p$DB_PASSWORD -Dhutoma \
#    -e "INSERT INTO feature_toggle (devid, aiid, feature, state) VALUES (NULL, NULL, 'language-en', 'T1')"

docker exec -it $DB_IMAGE /usr/bin/mysql -h localhost -u$DB_USER -p$DB_PASSWORD -Dhutoma \
    -e "INSERT INTO feature_toggle (devid, aiid, feature, state) VALUES (NULL, NULL, 'language-es', 'T1')"

docker exec -it $DB_IMAGE /usr/bin/mysql -h localhost -u$DB_USER -p$DB_PASSWORD -Dhutoma \
    -e "INSERT INTO feature_toggle (devid, aiid, feature, state) VALUES (NULL, NULL, 'language-it', 'T1')"
