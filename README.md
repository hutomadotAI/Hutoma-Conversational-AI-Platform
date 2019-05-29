# Open Source Conversational AI Platform
Hu:toma AI is an open source platform designed to help you create compelling conversational interfaces with little effort and above industry accuracy. The platform includes a web console where to design complex interactions, an API Server, Logging and Analytics functionalities, NLP and Machine Learning algorithms and everything you might need to build a scalable Chatbot factory.  For comments, issues, suggestions please visit our community https://community.hutoma.ai.

### Demo
A [demo](https://console.hutoma.ai/accounts/login) of the platform can be accessed from our [main website](https://www.hutoma.ai). You can view an intro to the platform [here](https://www.youtube.com/watch?v=SJB8PMWG71M)

### Platform Documentation 
You can find some additional documentation about our platform [here](https://help.hutoma.ai). 

### Questions and Help
For anything else please [visit our community](https://community.hutoma.ai)

# Requirements
You will need to have installed:
- Docker (https://runnable.com/docker/getting-started/, then check the instructions for your Operating System)
- Docker-Compose (https://docs.docker.com/compose/install/)

For Mac and Windows users it is recommended to set the docker memory limit above 5GB.   

# Getting Started
1. Clone or Download the Repo to your local machine. 
2. Open a terminal window and go to directory where you just downloaded the project (ex. ~/Hutoma-Conversational-AI-Platform)
3. Type . launch.sh to run the setup - by default this will download the pre-build images from the public repository through docker-compose. The first time you run it will take a while as the database will be initialized, volumes created, etc. Subsequent runs should spin up faster.
4. Verify step 3 is completed by navigating to `https://localhost:8443`. Tell your browser to ignore the security warning due to the use of the self-signed certificate. If you see the login form then you can proceed to step 5, otherwise wait a bit more.
5. If the platform is up, go to a new terminal window and type `. create_test_user.sh` to create a test user
6. Go back to `https://localhost:8443` and login with:
    - username: `hello@nowhere.com`
    - password: `Pass@word1`


# Building from source code
You can also build your own images directly from source code. To do that:
* Make sure you have these 2 components installed
    * Java JDK 8 (https://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html)
    * Maven (to install on MAC type 'brew install maven'; for Linux install type 'apt-get install maven')
* Clone the repo
* Type ./clone_and_build.sh to download all the source code, and build all components from source
* Follow the Getting Started instructions above but use `. launch_local.sh` instead of `. launch.sh` in step 3 

Enjoy!



# Additional setup

## Running the Word2Vec service locally
1. If you wish to run the Word2Vec service locally, set the `launch.sh`'s `USE_LOCAL_W2V` variable to TRUE (`USE_LOCAL_W2V=true`). Set it to FALSE to use the public service (this is the recommended default)

## Customizing the test user 
A convenience script is included to create a user without having to go through the registration process.
1. Edit `create_test_user.sh` and change the `USER_EMAIL` variable to contain the email address you want to use. All remaining variables should just work with the existing defaults
2. If no errors are shown during the execution of the script, you should have now a new user created
3. Navigate to `https://localhost:8443`, tell your browser to ignore the security warning due to the use of the self-signed certificate, and login with:
    - username: (the email address you defined on step 1, or `hello@nowhere.com` if you haven't changed this)
    - password: `Pass@word1`

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
## Enabling additional languages (optional)
You can define which languages to use by changing the `languages_array` variable. If you make changes to this then you'll also need to update the `languages_w2v_files` variable to include the respective Word2Vec vector pickled files. Recommended to leave this as it is for now. The only built-in language is English, which is always enabled by default. To support Spanish and Italian, you need to tell the system to turn the support on. A convenience script `enable_languages.sh` is included to make this process easy. You just need to run the script, and wait up to a minute, and the new languages will now be accepted by the system.



# FAQ

How do I create a bot in Spanish?
Currently there is no way to do it through the web console. You will need to create a bot (which will default to English), and export it. Edit the exported JSON file, and look for the field
```
"language": "en"
```
Set it to "es" for Spanish, or "it" for Italian and save the file. Then either import the bod-inplace, or create a new one using the updated file.
Note, if you get an error message stating that the language is not supported, make sure you've only used one of the supported languages mentioned here, and that when you run the `enable_languages.sh` there were no errors.
