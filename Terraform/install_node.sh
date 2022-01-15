#! /bin/bash

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
. /.nvm/nvm.sh
nvm install node
cd ~
sudo yum install git -y
git clone https://github.com/lehai2909/terrafrom-web.git
cd terrafrom-web
npm install
npm start