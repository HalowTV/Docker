#!/bin/bash

###################################################################
#         Author: Daily Updates
#    Description: Installs Radarr, Sonarr, Jacket, Sabnzbd, Utorrent, Ombi, and Organizr.
#            Run: bash install.sh
###################################################################
# Color Reset
Color_Off='\033[0m'       # Reset

# Regular Colors
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Blue='\033[0;34m'         # Blue
Purple='\033[0;35m'       # Purple
Cyan='\033[0;36m'         # Cyan

# Get IP Address
default_iface=$(awk '$2 == 00000000 { print $1 }' /proc/net/route)
ip=$(ip addr show dev "$default_iface" | awk '$1 == "inet" { sub("/.*", "", $2); print $2 }')

update() {
	# Update system repos
	echo -e "\n ${Cyan} Updating package repositories.. ${Color_Off}"
	sudo apt -qq update 
}

installCurl() {
	# Curl
	echo -e "\n ${Cyan} Installing Curl.. ${Color_Off}"
	sudo apt-get install curl
}

addDockerUser() {
	# DockerUser
	echo -e "\n ${Cyan} Adding user to docker.. ${Color_Off}"
	sudo su -c "useradd docker -s /bin/bash -m"
	sudo usermod -aG docker docker
}

installDocker() {
	# Docker
	echo -e "\n ${Cyan} Installing Docker.. ${Color_Off}"
	curl -fsSL https://get.docker.com -o get-docker.sh
	sh get-docker.sh
}

installDockerCompose() {
	# docker-compose
	echo -e "\n ${Cyan} Installing Docker-Compose.. ${Color_Off}"
	curl -L https://github.com/docker/compose/releases/download/1.24.1/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
	sudo chmod +x /usr/local/bin/docker-compose
}

installOrganizr() {
	# Organizr
	echo -e "\n ${Cyan} Installing Organizr.. ${Color_Off}"
	sudo docker pull organizrtools/organizr-v2
	sudo docker create --name=organizr \-v /home/docker/organizr/config:/config \-e PGID=1001 -e PUID=1001  \-p 80:80 \organizrtools/organizr-v2
	sudo docker start organizr
}

installOMBI() {
	# OMBI
	echo -e "\n ${Cyan} Installing OMBI.. ${Color_Off}"
	sudo docker pull linuxserver/ombi
	sudo docker create --name=ombi \-v /home/docker/ombi/config:/config \-e PGID=1001 -e PUID=1001  \-p 3579:3579 \linuxserver/ombi
	sudo docker start ombi
}

installSonarr() {
	# Sonarr
	echo -e "\n ${Cyan} Installing Sonarr.. ${Color_Off}"
	sudo docker pull linuxserver/sonarr
	sudo docker create --name=sonarr \--restart=always \-p 8989:8989 \-e PUID=1001 -e PGID=1001 \-v /dev/rtc:/dev/rtc:ro \-v /home/docker/sonarr/config:/config \-v /home/docker/sonarr/tv:/tv \-v /home/docker/sonarr/downloads:/downloads \linuxserver/sonarr
	sudo docker start sonarr
}

installRadarr() {
	# Radarr
	echo -e "\n ${Cyan} Installing Radarr.. ${Color_Off}"
	sudo docker pull linuxserver/radarr
	sudo docker create --name=radarr \--restart=always \-p 7878:7878 \-e PUID=1001 -e PGID=1001 \-v /dev/rtc:/dev/rtc:ro \-v /home/docker/radarr/config:/config \-v /home/docker/radarr/movies:/movies \-v /home/docker/radarr/downloads:/downloads \linuxserver/radarr
	sudo docker start radarr
}

installJackett() {
	# Jackett
	echo -e "\n ${Cyan} Installing Jackett.. ${Color_Off}"
	sudo docker pull linuxserver/jackett
	sudo docker create --name=jackett \--restart=always \-p 9117:9117 \-e PUID=1001 -e PGID=1001 \-v /home/docker/jackett/config:/config \-v /home/docker/jackett/downloads:/downloads \linuxserver/jackett
	sudo docker start jackett
}

#comment or uncomment installSabnzbd or installUtorrent
installSabnzbd() {
	# Sabnzbd
	echo -e "\n ${Cyan} Installing Sabnzbd.. ${Color_Off}"
	sudo docker pull linuxserver/sabnzbd
	sudo docker create --name=sabnzbd \--restart=always \-p 8080:8080 \-e PUID=1001 -e PGID=1001 \-v /home/docker/sabnzbd/config:/config \-v /home/docker/sabnzbd/downloads:/downloads \-v /home/docker/sabnzbd/incomplete-downloads:/incomplete-downloads \linuxserver/sabnzbd
	sudo docker start sabnzbd
}

#installUtorrent() {
#	# Utorrent
#	echo -e "\n ${Cyan} Installing Utorrent.. ${Color_Off}"
#	sudo docker pull ekho/utorrent
#	sudo docker create --name=utorrent \--restart=always \-p 8081:8081 \-p 6881:6881 \-p 6881:6881/udp \-e PUID=1001 -e PGID=1001 \-v /home/docker/utorrent/data:/data \ekho/utorrent
#	sudo docker start utorrent
#}

clean() {
	# Sabnzbd
	echo -e "\n ${Cyan} Cleaning install.. ${Color_Off}"
	sudo rm get-docker.sh
	sudo rm install.sh
}

# RUN
update
installCurl
addDockerUser
installDocker
installDockerCompose
installOrganizr
installOMBI
installSonarr
installRadarr
installJackett
installSabnzbd
installUtorrent
clean

echo -e "\n ${Cyan} Just highlight URL do not right click.${Color_Off}"
echo "You can access Organizr here http://${ip}"
echo "You can access OMBI here http://${ip}:3579"
echo "You can access Sonarr here http://${ip}:8989"
echo "You can access Radarr here http://${ip}:7878"
echo "You can access Jackett here http://${ip}:9117"
echo "You can access Sabnzbd here http://${ip}:8080"
echo "You can access Utorrent here http://${ip}:8081"
