HDIR="/home/vagrant/work"

echo INSTALLING JENKINS PLUGINS
java -jar $HDIR/jenkins-cli.jar -s http://localhost:8080 install-plugin git
java -jar $HDIR/jenkins-cli.jar -s http://localhost:8080 install-plugin rvm
java -jar $HDIR/jenkins-cli.jar -s http://localhost:8080 install-plugin rake
echo INSTALLING JENKINS PLUGINS COMPLETE

echo RESTARTING JENKINS
java -jar $HDIR/jenkins-cli.jar -s http://localhost:8080 restart
echo RESTARTING JENKINS COMPLETE
