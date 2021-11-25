#!/bin/bash 

curl "https://raw.githubusercontent.com/tempuserdownload/Tempdownloads/main/lamp.sh" -o lamp.sh
curl "https://raw.githubusercontent.com/tempuserdownload/Tempdownloads/main/nextcloud.sh" -o nextcloud.sh
sudo chmod +x nextcloud.sh
sudo chmod +x lamp.sh
./lamp.sh
./nextcloud.sh




