SPATH=`pwd`

set -e

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
sudo apt-get install -y git
sudo apt-get install -y jenkins
sudo apt-get install -y postgresql
sudo apt-get install -y curl

sudo usermod -a -G admin jenkins

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
    sleep 10
    wget http://localhost:8080/jnlpJars/jenkins-cli.jar
    chmod a=rwx jenkins-cli.jar
    cd $SPATH
fi
echo DOWNLOAD JENKINS CLIENT COMPLETE

echo JENKINS-SETUP
su -l jenkins /vagrant/jenkins-setup-rails.sh
echo JENKINS-SETUP COMPLETE
