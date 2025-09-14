#!/bin/bash
sudo yum update -y
sudo yum install -y nginx
sudo yum install -y docker
sudo systemctl start nginx
sudo systemctl start docker
sudo systemctl enable nginx
sudo systemctl enable docker
echo "<h1>Nginx and Docker have been installed and started successfully on Amazon Linux Instance</h1>" > /usr/share/nginx/html/index.html