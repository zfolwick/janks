#! /usr/bin/env sh
echo hello, earth!


echo priming the warp core...
YLW="\e[1;33m"     # yellow coloration
NF="\e[0m"         # no-format of text color
NL="\n"            # new line
ENDL=${NF}${NL}    #end of formatted printf statements
user=$(whoami)


echo recognizing user: $(whoami)
###########################################
# java install
###########################################
#java_major_version="17"
#java_minor_version="0.3.1"
#printf "%b" "${YLW}installing java version: ${java_major_version}.${java_minor_version}${ENDL}"
#java_install_dir="/opt/jdk17"
#apt-get -qq update
#apt-get install -qq libc6-i386 libc6-x32 curl -y
#curl -sO https://download.oracle.com/java/${java_major_version}/latest/jdk-${java_major_version}_linux-x64_bin.tar.gz
#mkdir -p ${java_install_dir}
#tar -xf jdk-*_linux-x64_bin.tar.gz -C ${java_install_dir}
#
#export JAVA_HOME=${java_install_dir}/jdk-${java_major_version}.${java_minor_version}
#export PATH=$PATH:$JAVA_HOME/bin
#echo $(java -version)
#printf "%b" "${YLW}installed java version ${java_major_version}.${java_minor_version}${ENDL}"
#
############################################
## /java install
############################################
#
#echo tracking neutrino emissions...
#
############################################
## maven install
############################################
#maven_version="3.8.5"
#printf "%b" "${YLW}installing maven version: ${maven_version}${ENDL}"
#
#wget -q https://mirrors.estointernet.in/apache/maven/maven-3/${maven_version}/binaries/apache-maven-${maven_version}-bin.tar.gz
#tar -xf apache-maven-${maven_version}-bin.tar.gz -C /opt
#M2_HOME="/opt/apache-maven-${maven_version}"
#export PATH="$M2_HOME/bin:$PATH"
#
#echo $(mvn -version)
#printf "%b" "${YLW}installed maven version: ${maven_version}${ENDL}"

###########################################
# /maven install
###########################################



###########################################
# docker install
###########################################
#apt-get install -y apt-transport-https ca-certificates curl software-properties-common
#curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
#add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
#apt-cache policy docker-ce
#apt-get install -y docker-ce
#systemctl status docker
#printf "%b" "${YLW}installed docker${ENDL}"
printf "%b" "${YLW}configuring docker${ENDL}"
groupadd docker
useradd -aG docker ${user}
newgrp docker
###########################################
# /docker install
###########################################



###########################################
# selenoid UI install
###########################################
selenoid_version="1.8.1"
printf "%b" "${YLW}installing selenoid UI version: ${selenoid_version}${ENDL}"
#wget -q https://github.com/aerokube/cm/releases/download/${selenoid_version}/cm_linux_amd64
#chmod +x cm_linux_amd64
./cm_linux_amd64 selenoid download
./cm_linux_amd64 selenoid start


###########################################
# /selenoid UI install
###########################################

###########################################
echo completed updates and installs
