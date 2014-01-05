#!/bin/bash

gem update bundler
rvm cleanup all
rvm pkg uninstall libxml2
rvm reinstall all --force
