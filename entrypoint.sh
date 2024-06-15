#!/bin/bash
if [[ "$1" == "visualstudiocode" ]]; then
    echo "Inatalling visualstudiocode"
    wget https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64
    sudo apt install ./code_1.89.1-1715060508_amd64.deb
    sudo apt-get install wget gpg
    wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
    sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
    echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" |sudo tee /etc/apt/sources.list.d/vscode.list > /dev/null
rm -f packages.microsoft.gpg
sudo apt install apt-transport-https
sudo apt update
sudo apt install code

elif [[ "$1" == "option2" ]]; then
    echo "Running command for option 2"
else
	echo $1
    echo "Default command"
fi
