#! /bin/bash

apt update
apt install -y git apache2
cd /var/www/html
rm index.html -f
git init
git pull https://github.com/drehnstrom/space-invaders