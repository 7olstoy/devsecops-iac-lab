#!/usr/bin/env bash

# Install Apache2
apt-get update -y
apt-get install -y apache2

echo '<!doctype html><html><body><h1>With TERRAFORM from gitlab on ubuntu20!</h1></body></html>' > /var/www/html/index.html