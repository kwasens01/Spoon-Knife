#!/usr/bin/env bash

set -euo pipefail

init(){
    sudo apt update -y
    sudo apt upgrade -y
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

main(){
    init
    process_docker
}

main "$@"
