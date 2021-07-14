#!/bin/bash

sudo apt-get update -y
sudo apt-get install -y curl openssh-server ca-certificates tzdata perl
curl https://packages.gitlab.com/install/repositories/gitlab/gitlab-ee/script.deb.sh | sudo bash
sudo EXTERNAL_URL="http://$(curl ifconfig.io)" GITLAB_ROOT_PASSWORD="${gitlab_root_password}" apt-get install -y gitlab-ee