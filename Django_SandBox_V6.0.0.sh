#! /bin/bash
echo ""
: <<'COMMENT'
Made By:        Ahmad Muhammad Waddah.
App Version:    6.0
Purpose:        Create Django Project SandBox With Virtual Environment.
Description:
-   Get Directory Name and Django Apps Needed From The User.
-   Make New Directory For Project as User Insert it.
-   Creating Media Directory In Root Directory.
-   Create ".env - .gitignore" Files In Root Directory.
-   Create Vertual Environment and Activate it.
-   Install Some Packages With Pip3 and Freeze it Into requirements.txt File.
-   Create Django Project After Installing Django With Name 'project'.
-   Create Django Apps as Inserted By User.
-   Create urls.py File For Apps.
-   Create Templates Directory Under Each App.
-   Create Static Directory With Name 'Assets', Also SubDirectories For 'Images, Fonts, Styles, Scripts' For Each App. 
-   Add Installed Apps Into Project settins.py File.
COMMENT
#   Collecting Variables.
function collect_variables() {
    echo " ${GREEN}Directory Name.${NORM}"
    read -p "Please Enter New Directory Name: " DIRNME
    echo " ${GREEN}Django Apps Names.${NORM}"
    read -p "Please Insert Django Apps Names Separated By 'Space' : " DJNGAPPSLIST
}
#   Create New Directory
function create_new_directory() {
    mkdir ${DIRNME}
    cd ${DIRNME}
    echo "${BOLD}Directory \" ${DIRNME} \" Created.${NORM}"
}
#   Create Media Folder.
function create_MDA() {
    MDA="media"
    mkdir ${MDA}
    echo "${BOLD}Media Folder \" ${MDA} \" Created.${NORM}"
}
#   Create .env File.
function create_dot_env_file() {
    DOT_ENV=".env"
    touch "${DOT_ENV}"
    echo "${BOLD}File \" ${DOT_ENV} \" Created.${NORM}"
}
#   Create .env File.
function create_dot_gitignore_file() {
    DOT_GTIGNR=".gitignore"
    touch "${DOT_GTIGNR}"
    echo "${BOLD}File \" ${DOT_GTIGNR} \" Created.${NORM}"
}
#   Create Virtual Environment and Activate it.
function create_virtual_environment() {
    DIRENV="venv"
    python3 -m venv ${DIRENV}
    echo "${BOLD}Venv \" ${DIRENV} \" Created.${NORM}"
}
#   Acttivate Virtual Environment.
function activate_virtual_environment() {
    source ${DIRENV}/bin/activate
    echo "${BOLD}Venv \" ${DIRENV} \" Activated.${NORM}"
}
#   Installing Packages.
function install_packages() {
    cd ${DIRENV}
    pip3 install django wheel Pillow psycopg2-binary django-cors-headers
    echo "------------------------------------------------------------------------------------------"
    echo "${BOLD}Packages and Dependencies Installed.${NORM}"
}
#   Create Django Project.
function create_django_project() {
    DJNGPRJCT="project"
    cd ..
    django-admin startproject ${DJNGPRJCT} .
    echo "${BOLD}Project \" ${DJNGPRJCT} \" Created.${NORM}"
}
#   Create Django Apps.
function create_django_apps() {
    for DJNGAPP in ${DJNGAPPSLIST[*]};
    do
        python3 manage.py startapp ${DJNGAPP}
        echo "${BOLD}App \" ${DJNGAPP} \" Created.${NORM}"
        #   Create Templates Directory.
        TMPLT="templates"
        mkdir ${DJNGAPP}/${TMPLT}
        mkdir ${DJNGAPP}/${TMPLT}/${DJNGAPP}
        echo "${BOLD}Templates Folder \" ${DJNGAPP}/${TMPLT}/${DJNGAPP} \" Created.${NORM}"
        URLS_PY="urls.py"
        touch ${DJNGAPP}/${URLS_PY}
        echo from django.urls import path >> ${DJNGAPP}/${URLS_PY}
        echo "${BOLD}Templates Folder \" ${DJNGAPP}/${URLS_PY} \" Created.${NORM}"
        #   Create Assets Directories.    
        ASSTS="assets"
        FNTS="fonts"
        IMGS="images"
        STYLS="styles"
        SCRPTS="scripts"
        mkdir ${DJNGAPP}/${ASSTS}
        echo "${BOLD}Assets Folder \" ${DJNGAPP}/${ASSTS} \" Created.${NORM}"
        mkdir ${DJNGAPP}/${ASSTS}/${FNTS}
        echo "${BOLD}Assets Folder \" ${DJNGAPP}/${ASSTS}/${FNTS} \" Created.${NORM}"
        mkdir ${DJNGAPP}/${ASSTS}/${IMGS}
        echo "${BOLD}Assets Folder \" ${DJNGAPP}/${ASSTS}/${IMGS} \" Created.${NORM}"
        mkdir ${DJNGAPP}/${ASSTS}/${STYLS}
        echo "${BOLD}Assets Folder \" ${DJNGAPP}/${ASSTS}/${STYLS} \" Created.${NORM}"
        mkdir ${DJNGAPP}/${ASSTS}/${SCRPTS}
        echo "${BOLD}Assets Folder \" ${DJNGAPP}/${ASSTS}/${SCRPTS} \" Created.${NORM}"
    done
}
#   Add Apps to Installed Apps Into Settings.py File.
function add_app_to_installed_apps() {
    SETTINGS_FILE="${DJNGPRJCT}/settings.py"
    for DJNGAPP in ${DJNGAPPSLIST[*]};
    do
        sed -i -e '1h;2,$H;$!d;g' -re "s/(INSTALLED_APPS\s?=\s?\[[\n '._a-zA-Z,]*)/\1 '${DJNGAPP}.apps.${DJNGAPP^}Config',\n/g" ${SETTINGS_FILE}
        echo "${BOLD}App \" ${DJNGAPP} \" Added to Installed Apps In Settings.py File.${NORM}"
    done
}
#   Freeze Packages.
function freeze_packages() {
    pip3 freeze > requirements.txt
    echo "${BOLD}File Requirement.txt Created..${NORM}"
}
#   Main Function To Create Django SandBox.
function django_project_sandbox() {
    #   Style Variables.
    BOLD=$(tput bold)
    NORM=$(tput sgr0)
    GREEN=$(tput setaf 2)
    #   Collect Variables From User.
    collect_variables
    echo "------------------------------------------------------------------------------------------"
    #   Create New Directory Function Call
    create_new_directory
    echo "------------------------------------------------------------------------------------------"
    #   Create Media Folder Function Call.
    create_MDA
    echo "------------------------------------------------------------------------------------------"
    #   Create .env File Function Call.
    create_dot_env_file
    echo "------------------------------------------------------------------------------------------"
    #   Create .gitignore File Function Call.
    create_dot_gitignore_file
    echo "------------------------------------------------------------------------------------------"
    #   Create Virtual Environment Function Call.
    create_virtual_environment
    echo "------------------------------------------------------------------------------------------"
    #   Activate Virtual Environment Function Call.
    activate_virtual_environment
    echo "------------------------------------------------------------------------------------------"
    #   Installing Packages Function Call.
    install_packages
    echo "------------------------------------------------------------------------------------------"
    #   Create Django Project Function Call.
    create_django_project
    echo "------------------------------------------------------------------------------------------"
    #   Create Django Apps Function Call.
    create_django_apps
    echo "------------------------------------------------------------------------------------------"
    #   Add Installed Apps Into Settings.py Function Call.
    add_app_to_installed_apps
    echo "------------------------------------------------------------------------------------------"
    #   Freeze Packages Function Call.
    freeze_packages
    echo "------------------------------------------------------------------------------------------"
}
django_project_sandbox
