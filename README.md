# Introduction 
This is a set of files to support launching a simple, local version of the Hutoma system.

# Requirements
You will need to have installed:
1. Docker (https://runnable.com/docker/getting-started/, then check the instructions for your Operating System)
2. Docker-Compose (https://docs.docker.com/compose/install/)

# Getting Started
1. Determine if you want to use the public Word2Vec services, or run it locally (note that running it locally will require you to have an additional 20Gb of memory for the initialisation of the Word2Vec services in all languages)
2. Update `launch.sh`'s `USE_LOCAL_W2V` variable to reflect the decision form 1 (`USE_LOCAL_W2V=false` to use the public service - recommended! - or `USE_LOCAL_W2V=true` to use the services locally).
3. You can define which languages to use by changing the `languages_array` variable. If you make changes to this then you'll also need to update the `languages_w2v_files` variable to include the respective Word2Vec vector pickled files. Recommended to leave this as it is for now.
4. Run `launch.sh` - this will download all the docker container images and run it through docker-compose

You will see all the logging spew on the console. The first time you run it will take a while as the database will be initialized, volumes created, etc. Subsequent runs should spin up faster.
You can test whether the system is up or not by going to a browser and navigating to <http://localhost:8443>. It may take a little bit until the web console is fully available.


# Additional setup

## Creating a test user 
A convenience script is included to create a user without having to go through the registration process.
1. Edit `create_test_user.sh` and change the `USER_EMAIL` variable to contain the email address you want to use. All remaining variables should just work with the existing defaults
2. If no errors are shown during the execution of the script, you should have now a new user created
3. Navigate to `http://localhost:8443`, tell your browser to ignore the security warning due to the use of the self-signed certificate, and login with:
    - username: (the email address you defined on step 1, or `hello@nowhere.com` if you haven't changed this)
    - password: `Pass@word1`

## Enabling additional languages (optional)
The only built-in language is English, which is always enabled by default. To support Spanish and Italian, you need to tell the system to turn the support on. A convenience script `enable_languages.sh` is included to make this process easy. You just need to run the script, and wait up to a minute, and the new languages will now be accepted by the system.

## Enabling new user registration and password resets
If you want to enable the web console to support the creation of new users, you will need to add a few extra environment variables.

To add Google Re-Captcha support:
You will need to get your recaptcha public and private "keys" from Google (https://www.google.com/recaptcha/intro/v3.html), and update the following environment variables within the script:
```
DJANGO_RECAPTCHA_PUBLIC_KEY=
DJANGO_RECAPTCHA_PRIVATE_KEY=
```
Additionally, you will need a SMTP2GO account (https://www.smtp2go.com/), and update the following environment variables accordingly with an account that has permissions to use the SMTP service:
```
EMAIL_HOST_USER=
EMAIL_HOST_PASSWORD=
```


# FAQ

How do I create a bot in Spanish?
Currently there is no way to do it through the web console. You will need to create a bot (which will default to English), and export it. Edit the exported JSON file, and look for the field
```
"language": "en"
```
Set it to "es" for Spanish, or "it" for Italian and save the file. Then either import the bod-inplace, or create a new one using the updated file.
Note, if you get an error message stating that the language is not supported, make sure you've only used one of the supported languages mentioned here, and that when you run the `enable_languages.sh` there were no errors.