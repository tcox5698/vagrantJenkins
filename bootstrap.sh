SPATH=`pwd`

wget -q -O - http://pkg.jenkins-ci.org/debian/jenkins-ci.org.key | sudo apt-key add -
sudo echo 'deb http://pkg.jenkins-ci.org/debian binary/' >> /etc/apt/sources.list

sudo apt-get update
sudo apt-get install -y git
sudo apt-get install -y jenkins
sudo apt-get install -y postgresql
sudo apt-get install -y curl



if [ -e ./work ]
  then echo work dir exists
  else mkdir work
fi

if [ -e ./work/jenkins-cli.jar ]
  then echo jenkins-cli exists
  else
    cd work
    wget http://localhost:8080/jnlpJars/jenkins-cli.jar
    chmod a=rwx jenkins-cli.jar
    cd $SPATH
fi

su jenkins /vagrant/jenkins-setup-rails.sh
