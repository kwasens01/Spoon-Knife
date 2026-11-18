#!/usr/bin/env bash

set -euo pipefail

init(){
    sudo apt update -y
    sudo apt upgrade -y
    sudo apt install apt-utils -y
}

remove_docker(){
    apt list --installed | grep -i docker
    sudo systemctl stop docker

    sudo apt purge python3-dockerpty -y
    sudo apt purge python3-docker -y

    sudo apt purge docker-buildx-plugin -y
    sudo apt purge docker-compose-plugin -y

    sudo apt purge docker-compose -y
    sudo apt purge docker-ce-cli -y
    sudo apt purge docker-ce -y

    sudo apt autoremove -y

    apt list --installed | grep -i docker

}
install_docker(){
    sudo apt install docker-ce -y
    sudo apt install docker-ce-cli -y
    sudo apt install docker-compose -y
 
    apt list --installed | grep -i docker

}
process_docker(){
    remove_docker
    install_docker
}

start_apps(){
    #start nginx
    sudo apt install nginx -y
    #start docker nginx

    #start docker hello-world
    docker run --name hello-world-01 hello-world 

    #start docker selkies
    #docker run --name selkies -it -d --rm --shm-size=2g -p 8080:8080  ghcr.io/selkies-project/selkies/desktop:main-ubuntu26.04
}


install_apps(){
    #install nginx
    sudo apt install nginx -y
    #install selkies
    docker run --name selkies -it -d --rm --shm-size=2g -p 8080:8080  ghcr.io/selkies-project/selkies/desktop:main-ubuntu26.04
}

install_pwsh(){

    ##!/bin/bash
    ###################################
    # Prerequisites

    # Update the list of packages
    sudo apt-get update

    # Install pre-requisite packages.
    sudo apt-get install -y wget apt-transport-https software-properties-common

    # Get the version of Ubuntu
    source /etc/os-release

    # Download the Microsoft repository keys
    wget -q https://packages.microsoft.com/config/ubuntu/$VERSION_ID/packages-microsoft-prod.deb

    # Register the Microsoft repository keys
    sudo dpkg -i packages-microsoft-prod.deb

    # Delete the Microsoft repository keys file
    rm packages-microsoft-prod.deb

    # Update the list of packages after we added packages.microsoft.com
    sudo apt-get update

    ###################################
    # Install PowerShell
    sudo apt-get install -y powershell

    # Start PowerShell
    #pwsh

}


main(){
    init
    process_docker
}

main "$@"
