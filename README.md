I got tired of installing Radarr, Sonarr, Jackett, Sabnzbd, Utorrent, Ombi, and Organizr. Everytime i reformatted my server so i created a script that did it all on its own.
It gets the latest version of each program.

Radarr will help you manage movies and download them.
Sonarr will manage your TV Shows and download them.
Jackett is used to manage all your torrent sites to add to Radarr and Sonarr. (trouble making it work will fix later)
Sabnzbd when used with a Usenet account and scraper will make your life easier downloading any sized files.
Utorrent used for downloading torrents.
Ombi will create a website for users to request movies and TV shows and automatically show them if you already have that movie or TV show.
Oranizr allows you to manage just about all these things in one easy to use page and also allows your users to see a calendar form Radarr and Sonarr telling them of upcoming movies and shows and if they have been downloaded or not.

I'm not a programmer just put this together seeing a lot of examples. so if you guys find mistakes or ways to make things easier i will gladly take tips and advice.
its a much smaller script now but does the same thing except created within docker containers. Thanks to the suggestion @urgodfather gave. Separate containers are the better way to go for this.

install ubun
wget https://raw.githubusercontent.com/HalowTV/Docker/master/install.sh && bash install.sh
 
ip

You can access Organizr here http://url
You can access OMBI here http://url:3579
You can access Sonarr here http://url:8989
You can access Radarr here http://url:7878
You can access Jackett here http://url:9117
You can access Sabnzbd here http://url:8080
You can access Utorrent here http://url:8081
