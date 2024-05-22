# jeev-media
Media Content Application Suite

To deploy:

  1. Copy all files to media server
  2. From within the folder run `sudo docker-compose -f docker-compose.yml up -d`
  3. Copy the contents of crontab
  4. Append it to the end of you cronfile `crontab -e` and save
  5. Install rclone and config your putio account as per: https://rclone.org/putio/
  6. Set remote name putio
  7. Configure nginx and set up reverse proxy to all containers
  8. Enable firewall on host
  9. Configure and run inital setup on application as needed
  10. Enjoy!

Stack breakdown and comprehensive instructions available here: https://www.cloudopswisdom.com/2023/09/how-to-build-public-facing-plex.html 

Disclaimer: This is for demonstratitive purposes only. I do not condone piracy.
