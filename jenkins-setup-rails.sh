#!/bin/bash

#SETS UP JENKINS USER WITH RVM AND RAILS - RUN AS JENKINS USER

set -e

\curl -sSL https://get.rvm.io | bash -s stable --rails

echo "[[ -s $HOME/.rvm/scripts/rvm ]] && source $HOME/.rvm/scripts/rvm" > /home/vagrant/.profile

echo "---\ngem: --no-ri --no-rdoc" > /home/vagrant/.gemrc

git config --global user.email "jenkins@tcdev.com"
git config --global user.name "Jenkins TCDEV"
