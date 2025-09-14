#!/bin/bash
sudo apt-get update -y
sudo apt-get install -y nginx
sudo apt-get install -y docker
sudo systemctl start nginx
sudo systemctl start docker
sudo systemctl enable nginx
sudo systemctl enable docker
echo "<h1>Nginx and Docker have been installed and started successfully on Ubuntu Instance</h1>" > /var/www/html/index.html