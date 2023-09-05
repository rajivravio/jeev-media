#!/bin/bash
USERNAME=testuser #replace this with your username
PUTIO_FOLDER_ID=11111111 #replace this with your putio folder ID

for FILE in /home/${USERNAME}/media/media/torrent_files/*; 
do echo -e "Downloading... $FILE to putio"; /usr/local/bin/kaput transfers:add `cat "${FILE}"`; sleep 3; /usr/local/bin/kaput transfers:add -f ${PUTIO_FOLDER_ID} `/usr/bin/transmission-show -m "${FILE}"`; rm "${FILE}"; done
