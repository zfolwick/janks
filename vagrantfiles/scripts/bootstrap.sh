#! /usr/bin/env sh


YLW="\e[1;33m"     # yellow coloration
NF="\e[0m"         # no-format of text color
NL="\n"            # new line
ENDL=${NF}${NL}    #end of formatted printf statements
user=${whoami}

echo hello, ${user}!
############################################
## java install
############################################
java_version="17-amazon-corretto-jdk"
printf "%b" "${YLW}installing java version: ${java_version}"
wget -O- https://apt.corretto.aws/corretto.key | apt-key add -
add-apt-repository -y 'deb https://apt.corretto.aws stable main'
apt-get install -y java-${java_version}
echo $(java -version)
printf "%b" "${YLW}installed java version: ${java_version}"
#
###########################################
# /java install
###########################################

###########################################
# maven install
###########################################
maven_version="3.8.5"
printf "%b" "${YLW}installing maven version: ${maven_version}${ENDL}"

wget -q https://mirrors.estointernet.in/apache/maven/maven-3/${maven_version}/binaries/apache-maven-${maven_version}-bin.tar.gz
tar -xf apache-maven-${maven_version}-bin.tar.gz -C /opt
M2_HOME="/opt/apache-maven-${maven_version}"
export PATH="$M2_HOME/bin:$PATH"

echo $(mvn -version)
printf "%b" "${YLW}installed maven version: ${maven_version}${ENDL}"

###########################################
# /maven install
###########################################


###########################################
# docker install
###########################################
apt-get install -y apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
apt-cache policy docker-ce
apt-get install -y docker-ce
systemctl status docker
printf "%b" "${YLW}installed docker${ENDL}"
printf "%b" "${YLW}configuring docker${ENDL}"
groupadd docker
usermod -aG docker ${user}
newgrp docker
###########################################
# /docker install
###########################################



###########################################
# selenoid install
###########################################
selenoid_version="1.8.1"
chrome_version="99.0"
printf "%b" "${YLW}installing selenoid UI version: ${selenoid_version}${ENDL}"
wget -q https://github.com/aerokube/cm/releases/download/${selenoid_version}/cm_linux_amd64
chmod +x cm_linux_amd64
./cm_linux_amd64 selenoid start --browsers "chrome:${chrome_version}"

#
echo completed updates and installs
