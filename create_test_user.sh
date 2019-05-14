#!/bin/bash

USER_EMAIL='hello@nowhere.com'
DB_USER=root
DB_PASSWORD=password
USER_DEV_ID='a2b9d970-521c-493d-86b1-8d756c85d226'
USER_DEV_TOKEN='eyJhbGciOiJIUzI1NiIsInppcCI6IkRFRiJ9.eNqqVgry93FVsgJT8W5Brq5KOkrFpUlAkUSjJMsUS3MDXVMjw2RdE0vjFF0LsyRDXYsUc1OzZAvTFCMjM6VaAAAAAP__.fDY6_exr50JsiADlG8YAhrVS5nHQZCI6PvbXpt-yf_I'
# Encrypted password for 'Pass@word1'
USER_ENCRYPTED_PWD='pbkdf2_sha256$120000$DqgMqpg5CqYP$ilDHNbOjqm1IYxN4FOCZ6vJF2gMdBMKFNiiL3YO4gJ8='
DB_IMAGE='hutomaoss_api-db_1'


docker exec -it $DB_IMAGE /usr/bin/mysql -h localhost -u$DB_USER -p$DB_PASSWORD -Dhutoma \
    -e "INSERT INTO users (dev_token, plan_id, dev_id, valid, internal) VALUES ('$USER_DEV_TOKEN', 1, '$USER_DEV_ID', 1, 0)"


docker exec -it $DB_IMAGE /usr/bin/mysql -h localhost -u$DB_USER -p$DB_PASSWORD -Ddjango   \
    -e "INSERT INTO auth_user (password, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined) VALUES ('$USER_ENCRYPTED_PWD', 1, '$USER_EMAIL', 'Test', 'User', '$USER_EMAIL', 0, 1, '2019-01-01')"


docker exec -it $DB_IMAGE /usr/bin/mysql -h localhost -u$DB_USER -p$DB_PASSWORD -Ddjango \
    -e "INSERT INTO account_emailaddress (email, verified, \`primary\`, user_id) SELECT '$USER_EMAIL', 1, 1, id FROM auth_user WHERE email='$USER_EMAIL'"


docker exec -it $DB_IMAGE /usr/bin/mysql -h localhost -u$DB_USER -p$DB_PASSWORD -Ddjango \
    -e "INSERT INTO users_profile (dev_id, user_id, login_count) SELECT '$USER_DEV_ID', id, 0 FROM auth_user WHERE email='$USER_EMAIL'"