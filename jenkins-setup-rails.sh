#!/bin/bash

#SETS UP JENKINS USER WITH RVM AND RAILS - RUN AS JENKINS USER

echo WMO AM I
echo `whoami`

echo CURRENT DIR
echo `pwd`

#set -e

echo INSTALL RVM AND RAILS
curl -sSL https://get.rvm.io | bash -s stable --rails
echo INSTALL RVM AND RAILS COMPLETE

echo CONFIG PROFILE WITH RVM
if [ -e profile-rvm-configged ]
  then echo profile configged with rvm already
  else
    echo TRYING TO WRITE TO /var/lib/jenkins/.profile
    echo "[[ -s $HOME/.rvm/scripts/rvm ]] && source $HOME/.rvm/scripts/rvm" > /var/lib/jenkins/.profile
    echo FINISHED WRITING TO .profile
    touch profile-rvm-configged
fi
echo CONFIG PROFILE WITH RVM COMPLETE

echo CONGIF GEMRC
if [ -e gemrc-rvm-configged ]
  then echo gemrc configged with rvm already
  else
    echo "---\ngem: --no-ri --no-rdoc" > /var/lib/jenkins/.gemrc
    touch gemrc-rvm-configged
fi

echo CONFIG GEMRC COMPLETE


git config --global user.email "jenkins@tcdev.com"
git config --global user.name "Jenkins TCDEV"



