#!/bin/bash 

curl https://raw.githubusercontent.com/tempuserdownload/Tempdownloads/main/Bash/lamp.sh -o lamp.sh
curl https://raw.githubusercontent.com/tempuserdownload/Tempdownloads/main/Bash/nextcloud.sh nextcloud.sh
sudo chmod +x nextcloud.sh
sudo chmod +x lamp.sh
./lamp.sh
./nextcloud




