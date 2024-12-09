#!/bin/bash

IP=$(hostname -I | awk '{print $2}')
REMOTE_DIR="/home/vagrant/"

echo "Assegnazione IP macchina"

if [ "$IP" == "192.168.0.20" ]; then
    sudo hostnamectl set-hostname machine
        
    else 
    echo "Assegnoazione hostname non riuscita: non sono presenti macchine con gli IP richiesti"

fi

echo "Controllo se ansible è installato..."

which ansible > /dev/null
if [ $? -ne 0 ]; then
    echo "Installazione di ansible in corso"
    sudo yum install -y epel-release
    sudo yum install -y ansible
    ansible-galaxy collection install containers.podman
fi


cd $REMOTE_DIR/ansible/


ansible-playbook -i inventory main.yml -vvv