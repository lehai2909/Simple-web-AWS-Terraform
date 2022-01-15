#! /bin/bash

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
. /.nvm/nvm.sh
nvm install node
cd ~
sudo yum install git -y
git clone https://github.com/lehai2909/Simple-web-AWS-Terraform.git
cd Simple-web-AWS-Terraform/Web-nodejs
npm install
npm start