#!/bin/bash

echo UPDATING RUBY ENVIRONMENT

set -e

if [ -e ruby-updated ]
  then
    gem update bundler
    rvm cleanup all
    rvm pkg uninstall libxml2

    echo RVM REINSTALL ALL FORCE
    rvm reinstall 2.1.0 --force
    touch ruby-updated
    echo RVM REINSTALL ALL FORCE COMPLETE
  else
    echo RUBY ALREADY UPDATED according to ruby-updated file
fi
echo UPDATING RUBY ENVIRONMENT COMPLETE
