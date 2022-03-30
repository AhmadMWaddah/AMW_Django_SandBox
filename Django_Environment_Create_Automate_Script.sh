#! /bin/bash

echo ""

# Author.
echo "Made By: Ahmad Muhammad Waddah."
echo "App Version: 1.6"
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

	#Venv.
	VENV_NAME="${DIRECTORY_NAME}_env"
	python3 -m venv ${VENV_NAME}
	echo "${BOLD}Venv \" ${VENV_NAME} \" Created.${NORM}"
	echo "------------------------------------------------------------"
	source ${VENV_NAME}/bin/activate
	echo "${BOLD}Venv \" ${VENV_NAME} \" Activated.${NORM}"
	echo "------------------------------------------------------------"

	# Installing Packages.
	cd ${VENV_NAME}
	pip3 install django wheel Pillow psycopg2-binary python-decouple djangorestframework django-extensions django-rest-swagger django-adminactions django-storages django-allauth
	cd ..
	pip3 freeze > requirements.txt
	echo "${BOLD}Packages and Dependencies Installed.${NORM}"
	echo "------------------------------------------------------------"

	# Installing Django Project.
	PROJECT_NAME=${DIRECTORY_NAME}
	django-admin startproject ${PROJECT_NAME} .
	echo "${BOLD}Project \" ${PROJECT_NAME} \" Created.${NORM}"
	echo "------------------------------------------------------------"

	#Installing Django App.
	APP_NAME="${PROJECT_NAME}_app_main"
	python3 manage.py startapp ${APP_NAME}
	echo "${BOLD}Project \" ${APP_NAME} \" Created.${NORM}"
	echo "------------------------------------------------------------"

	# # Migrations
	python3 manage.py makemigrations
	python3 manage.py migrate
	echo "${BOLD}Database Migration Done.${NORM}"
	echo "------------------------------------------------------------"

	# Create Superuser.
	USERNAME="amw"
	EMAIL="amw@amw.amw"
	PASSWORD=123
	echo "from django.contrib.auth.models import User; User.objects.create_superuser('${USERNAME}', '${EMAIL}', '${PASSWORD}')" | python manage.py shell
	echo "${BOLD}Super User \" ${USERNAME} \" Created${NORM}"
	echo "------------------------------------------------------------"

	# Notifications.
	echo "${BOLD}Remmeber To Configure: ${NORM}"
	echo "------------------------------------------------------------"
	echo "${BOLD}1- Installed Apps.${NORM}"
	echo "${BOLD}2- Static FIles.${NORM}"
	echo "${BOLD}3- Media.${NORM}"
	echo "${BOLD}4- Others.${NORM}"
	echo "------------------------------------------------------------"

	# Run Server
	python3 manage.py runserver
}

django_project_sandbox