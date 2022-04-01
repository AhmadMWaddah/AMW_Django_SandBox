#! /bin/bash

echo ""

: << 'COMMENT'
What's New in version 2.2:
Changed style to seprate functions to make code easier.
added script commad to add installed app into installed apps in settins.py file.
COMMENT

# Author.
echo "Made By: Ahmad Muhammad Waddah."
echo "App Version: 1.9"
echo "Purpose: Create Django Project Template."
echo "------------------------------------------------------------"

# Create New Directory
function create_new_directory() {
	read -p "Please Insert New Directory Name: " DIRECTORY_NAME
	mkdir ${DIRECTORY_NAME}
	cd ${DIRECTORY_NAME}
	echo "${BOLD}Directory \" ${DIRECTORY_NAME} \" Created.${NORM}"
}
# Create Virtual Environment and Activate it..
function create_virtual_environment() {
	VENV_NAME="${DIRECTORY_NAME}_env"
	python3 -m venv ${VENV_NAME}
	echo "${BOLD}Venv \" ${VENV_NAME} \" Created.${NORM}"
}
# Acttivate Virtual Environment.
function activate_virtual_environment() {
	source ${VENV_NAME}/bin/activate
	echo "${BOLD}Venv \" ${VENV_NAME} \" Activated.${NORM}"
}
# Installing Packages.
function install_packages() {
	cd ${VENV_NAME}
	pip3 install django wheel Pillow psycopg2-binary django-cors-headers python-decouple djangorestframework django-extensions django-rest-swagger django-bulma django-adminactions django-storages django-allauth
	cd ..
	pip3 freeze > requirements.txt
	echo "${BOLD}Packages and Dependencies Installed.${NORM}"
	echo "${BOLD}File \' Requirement.txt \' Also Created..${NORM}"
}
# Create Django Project.
function create_django_project() {
	PROJECT_NAME=${DIRECTORY_NAME}
	django-admin startproject ${PROJECT_NAME} .
	echo "${BOLD}Project \" ${PROJECT_NAME} \" Created.${NORM}"
}
# Create Media Folder.
function create_media_folder() {
	MEDIA_DIRECTORY_NAME="${PROJECT_NAME}_media"
	mkdir ../${PROJECT_NAME}/${MEDIA_DIRECTORY_NAME}
	echo "${BOLD}Media Folder \" ${MEDIA_DIRECTORY_NAME} \" Created.${NORM}"
}
# Install Django App.
function create_django_main_app() {
	APP_NAME="${PROJECT_NAME}_app_main"
	python3 manage.py startapp ${APP_NAME}
	echo "${BOLD}App \" ${APP_NAME} \" Created.${NORM}"
}
# Add App to Installed Apps Into Settings.py File.
function add_app_to_installed_apps() {
	pwd
	SETTINGS_FILE="${PROJECT_NAME}/settings.py"
	sed -i -e '1h;2,$H;$!d;g' -re "s/(INSTALLED_APPS\s?=\s?\[[\n '._a-zA-Z,]*)/\1    '${APP_NAME}',\n/g" ${SETTINGS_FILE}
	echo "${BOLD}App \" ${APP_NAME} \" Added to Installed Apps In Settings.py File.${NORM}"
}
# Create Templates Directory.
function create_templates_directory() {
	TEMPLATE_DIRECTORY_NAME="${APP_NAME}_templates"
	mkdir ${APP_NAME}/${TEMPLATE_DIRECTORY_NAME}
	echo "${BOLD}Templates Folder \" ${TEMPLATE_DIRECTORY_NAME} \" Created.${NORM}"
}
# Create Static Files Directory.
function create_static_files_directory() {
	STATIC_FILES_DIRECTORY_NAME="${APP_NAME}_assets"
	mkdir ${APP_NAME}/${STATIC_FILES_DIRECTORY_NAME}
	echo "${BOLD}Assets Folder \" ${STATIC_FILES_DIRECTORY_NAME} \" Created.${NORM}"
}
# Database Migrations.
function database_migrations() {
	python3 manage.py makemigrations
	python3 manage.py migrate
	echo "${BOLD}Database Migration Done.${NORM}"
}
# Create Superuser.
function create_django_admin_user() {
	USERNAME="amw"
	EMAIL="amw@amw.amw"
	PASSWORD=123
	echo "from django.contrib.auth.models import User; User.objects.create_superuser('${USERNAME}', '${EMAIL}', '${PASSWORD}')" | python manage.py shell
	echo "${BOLD}Super User \" ${USERNAME} \" With Password \" ${PASSWORD} \" Created${NORM}"
}
# Create .env File.
function create_dot_env_file() {
	ENV_FILE_NAME="${PROJECT_NAME}_env_file.env"
	touch "../${PROJECT_NAME}/${ENV_FILE_NAME}"	
	echo "${BOLD}.env File \" ${ENV_FILE_NAME} \" Created.${NORM}"
}
# Display Notes About Configurations.
function display_configurations_notes() {
	echo "${BOLD}Remmeber To Configure: ${NORM}"
	echo "------------------------------------------------------------"
	echo "${BOLD}1- Add Installed Apps.${NORM}"
	echo "${BOLD}2- Configure Static FIles.${NORM}"
	echo "${BOLD}3- Configure Media Files.${NORM}"
	echo "${BOLD}4- Configure Templates Files.${NORM}"
}
# Run Server.
function run_django_server() {
	python3 manage.py runserver
}
function django_project_sandbox(){

	# Style Variables.
	BOLD=$(tput bold)
	NORM=$(tput sgr0)

	# Create New Directory Function Call
	create_new_directory
	echo "------------------------------------------------------------"

	# Create Virtual Environment Function Call.
	create_virtual_environment
	echo "------------------------------------------------------------"

	# Activate Virtual Environment Function Call.
	activate_virtual_environment
	echo "------------------------------------------------------------"

	# Installing Packages Function Call.
	install_packages
	echo "------------------------------------------------------------"

	# Create Django Project Function Call.
	create_django_project
	echo "------------------------------------------------------------"

	# Create Media Folder Finction Call.
	create_media_folder
	echo "------------------------------------------------------------"

	# Create Django App Function Call.
	create_django_main_app
	echo "------------------------------------------------------------"

	# Add App Into Installed App List in Settings.py File Function Call.
	add_app_to_installed_apps
	echo "------------------------------------------------------------"

	# Create Templates Directory Function Call.
	create_templates_directory
	echo "------------------------------------------------------------"

	# Create Static Files Directory Function Call.
	create_static_files_directory
	echo "------------------------------------------------------------"

	# Database Migrations Funcation Call.
	database_migrations
	echo "------------------------------------------------------------"

	# Create Superuser Function Call.
	create_django_admin_user
	echo "------------------------------------------------------------"

	# Create .env File Function Call.
	create_dot_env_file
	echo "------------------------------------------------------------"

	# Display Notes About Configurations Function Call.
	display_configurations_notes
	echo "------------------------------------------------------------"

	# Run Server Funtion Call.
	run_django_server
}
django_project_sandbox
