#!/bin/bash
#sleep 10
USERNAME=testuser #replace this with your username

do_the_action () {
  date +"Putio to Server copy started at %H:%M:%S"
  sleep 1
  # Use this for rclone
  date +"%H:%M:%S: Starting transfers from putio to Server"
  rclone move putio:/ /home/${USERNAME}/media/media/putio_downloads/ --delete-empty-src-dirs -vv
  date +"---> %H:%M:%S: Completed transfers from putio"	
  echo -e "\n"
  date +"%H:%M:%S: Starting transfers from putio_downloads to watched_downloads"
  mv /home/${USERNAME}/media/media/putio_downloads/* /home/${USERNAME}/media/media/watched_downloads/
  date +"--->%H:%M:%S: Completed transfers from putio_downloads to watched_downloads"
  echo -e "\n"
  date +"%H:%M:%S: Updating permissions on transferred files"
  chown -R ${USERNAME}:${USERNAME} /home/${USERNAME}/media/media/watched_downloads/
  chmod -R 755 /home/${USERNAME}/media/media/watched_downloads/
  date +"%H:%M:%S: Shipping any pending transfer requests requests back to putio"
  /home/${USERNAME}/docker/scripts/serverToPutio.sh  >> /home/${USERNAME}/docker/logs/putioTransferLogs.log
  date +"---> %H:%M:%S: Transfer queues updated in putio at %H:%M:%S"
  echo -e "\n"
}

previous_instance_active () {
  pgrep -fa bash | grep -v "^$$ " | grep /home/${USERNAME}/docker/scripts/copyPutioToServer.sh 
}

if previous_instance_active || [ $(rclone ls putio:/ | wc -c) + $(ls /home/${USERNAME}/media/media/torrent_files | wc -c) -lt 1 ];
then
  sleep 1 
  #date +"%H:%M:%S: Duplicate instance of scheduled transfers is still active, PID listed above, skipping... "
else
do_the_action
fi
