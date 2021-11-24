#!/bin/bash 

curl https://raw.githubusercontent.com/Knuffelbeer4game/ProjectFurno/main/Bash/lamp.sh?token=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 -o lamp.sh
curl https://raw.githubusercontent.com/Knuffelbeer4game/ProjectFurno/main/Bash/nextcloud.sh?token=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 nextcloud.sh
sudo chmod +x nextcloud.sh
sudo chmod +x lamp.sh
./lamp.sh
./nextcloud




