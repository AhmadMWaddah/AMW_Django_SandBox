#! /bin/bash

echo ""

# Author.
echo "Made By: Ahmad Muhammad Waddah."
echo "App Version: 1.8"
echo "Purpose: Create Django Project Template."
echo "------------------------------------------------------------"

function django_project_sandbox(){

	# Style Variables.
	BOLD=$(tput bold)
	NORM=$(tput sgr0)

	# Create New Directory
	read -p "Please Insert New Directory Name: " DIRECTORY_NAME
	mkdir ${DIRECTORY_NAME}
	cd ${DIRECTORY_NAME}
	echo "${BOLD}Directory \" ${DIRECTORY_NAME} \" Created.${NORM}"
	echo "------------------------------------------------------------"

	# Create Virtual Environment and Activate it..
	VENV_NAME="${DIRECTORY_NAME}_env"
	python3 -m venv ${VENV_NAME}
	echo "${BOLD}Venv \" ${VENV_NAME} \" Created.${NORM}"
	echo "------------------------------------------------------------"
	source ${VENV_NAME}/bin/activate
	echo "${BOLD}Venv \" ${VENV_NAME} \" Activated.${NORM}"
	echo "------------------------------------------------------------"

	# Installing Packages.
	cd ${VENV_NAME}
	pip3 install django wheel Pillow psycopg2-binary django-cors-headers python-decouple djangorestframework django-extensions django-rest-swagger django-adminactions django-storages django-allauth
	cd ..
	pip3 freeze > requirements.txt
	echo "${BOLD}Packages and Dependencies Installed.${NORM}"
	echo "${BOLD}File \' Requirement.txt \' Also Created..${NORM}"
	echo "------------------------------------------------------------"

	# Installing Django Project.
	PROJECT_NAME=${DIRECTORY_NAME}
	django-admin startproject ${PROJECT_NAME} .
	echo "${BOLD}Project \" ${PROJECT_NAME} \" Created.${NORM}"
	echo "------------------------------------------------------------"

	# Creating Media Folder.
	MEDIA_DIRECTORY_NAME="${PROJECT_NAME}_media"
	mkdir ../${PROJECT_NAME}/${MEDIA_DIRECTORY_NAME}
	echo "${BOLD}Media Folder \" ${MEDIA_DIRECTORY_NAME} \" Created.${NORM}"
	echo "------------------------------------------------------------"

	# Installing Django App.
	APP_NAME="${PROJECT_NAME}_app_main"
	python3 manage.py startapp ${APP_NAME}
	echo "${BOLD}App \" ${APP_NAME} \" Created.${NORM}"
	echo "------------------------------------------------------------"

	# Creating Templates Directory.
	TEMPLATE_DIRECTORY_NAME="${APP_NAME}_templates"
	mkdir ${APP_NAME}/${TEMPLATE_DIRECTORY_NAME}
	echo "${BOLD}Templates Folder \" ${TEMPLATE_DIRECTORY_NAME} \" Created.${NORM}"
	echo "------------------------------------------------------------"

	# Creating Static Files Directory.
	STATIC_FILES_DIRECTORY_NAME="${APP_NAME}_assets"
	mkdir ${APP_NAME}/${STATIC_FILES_DIRECTORY_NAME}
	echo "${BOLD}Assets Folder \" ${STATIC_FILES_DIRECTORY_NAME} \" Created.${NORM}"
	echo "------------------------------------------------------------"

	# Database Migrations
	python3 manage.py makemigrations
	python3 manage.py migrate
	echo "${BOLD}Database Migration Done.${NORM}"
	echo "------------------------------------------------------------"

	# Create Superuser.
	USERNAME="amw"
	EMAIL="amw@amw.amw"
	PASSWORD=123
	echo "from django.contrib.auth.models import User; User.objects.create_superuser('${USERNAME}', '${EMAIL}', '${PASSWORD}')" | python manage.py shell
	echo "${BOLD}Super User \" ${USERNAME} \" With Password \" ${PASSWORD} \" Created${NORM}"
	echo "------------------------------------------------------------"

	# Creating .env File.
	ENV_FILE_NAME="${PROJECT_NAME}_env_file.env"
	touch "../${PROJECT_NAME}/${ENV_FILE_NAME}"	
	echo "${BOLD}.env File \" ${ENV_FILE_NAME} \" Created.${NORM}"
	echo "------------------------------------------------------------"

	# Notifications.
	echo "${BOLD}Remmeber To Configure: ${NORM}"
	echo "------------------------------------------------------------"
	echo "${BOLD}1- Add Installed Apps.${NORM}"
	echo "${BOLD}2- Configure Static FIles.${NORM}"
	echo "${BOLD}3- Configure Media Files.${NORM}"
	echo "${BOLD}4- Configure Templates Files.${NORM}"
	echo "------------------------------------------------------------"

	# Run Server
	python3 manage.py runserver
}

django_project_sandbox