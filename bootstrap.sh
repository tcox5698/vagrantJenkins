SPATH=`pwd`

set -e

export LC_CTYPE="en_US.utf8"

echo CONFIGURING APT-JENKINS
if [ -e apt-jenkins-configured ]
  then echo apt jenkins configured
  else
    wget -q -O - http://pkg.jenkins-ci.org/debian/jenkins-ci.org.key | sudo apt-key add -
    sudo echo 'deb http://pkg.jenkins-ci.org/debian binary/' >> /etc/apt/sources.list
    touch apt-jenkins-configured
fi
echo CONFIGURING APT-JENKINS COMPLETE

echo APT-GET INSTALLS
sudo apt-get update
sudo apt-get install -y git jenkins postgresql curl libxml2 libxslt-dev libxml2-dev libpq-dev nodejs libqtwebkit-dev xvfb
echo APT-GET INSTALLS COMPLETE

sudo usermod -a -G admin jenkins

echo CONFIGURE POSTGRES
pg_dropcluster --stop 9.1 main
pg_createcluster --start --locale en_US.UTF8 -e UTF-8 9.1 main
sudo service postgresql stop
sudo mv /etc/postgresql/9.1/main/pg_hba.conf /etc/postgresql/9.1/main/pg_hba.conf.bak
sudo cp /vagrant/pg_hba.conf /etc/postgresql/9.1/main/pg_hba.conf
sudo service postgresql start
echo CONFIGURE POSTGRES COMPLETE


echo CONFIG JENKINS USER IN POSTGRES
sudo su - postgres bash -c 'createuser jenkins -s -d'
echo CONFIG JENKINS USER IN POSTGRES COMPLETE

echo MAKE WORK DIR
if [ -e ./work ]
  then echo work dir exists
  else mkdir work
fi
echo MAKE WORK DIR COMPLETE

echo DOWNLOAD JENKINS CLIENT
if [ -e ./work/jenkins-cli.jar ]
  then echo jenkins-cli exists
  else
    cd work
    sleep 20
    wget http://localhost:8080/jnlpJars/jenkins-cli.jar
    chmod a=rwx jenkins-cli.jar
    cd $SPATH
fi
echo DOWNLOAD JENKINS CLIENT COMPLETE

echo JENKINS-SETUP
su -l jenkins /vagrant/jenkins-setup-rails.sh
echo JENKINS-SETUP COMPLETE

echo JENKINS-UPDATE RUBY ENV
su -l jenkins /vagrant/jenkins-update-ruby-env.sh
echo JENKINS UPDATE RUBY ENV COMPLETE

echo JENKINS-INSTALL-PLUGINS
/vagrant/jenkins-install-plugins.sh
echo JENKINS-INSTALL-PLUGINS-COMPLETE

