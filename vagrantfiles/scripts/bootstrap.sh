#! /usr/bin/env sh


YLW="\e[1;33m"     # yellow coloration
NF="\e[0m"         # no-format of text color
NL="\n"            # new line
ENDL=${NF}${NL}    #end of formatted printf statements
user=$1

echo hello, ${user}!
wout () {
  printf "%b" "${YLW}$1${ENDL}"
}

is_installed() {
    if command -v $1 >/dev/null; then
        true
    else
        false
    fi
    return
}


############################################
## java install
############################################

if is_installed java ; then
    wout "java is already installed. version is: $(java --version)"
else
    java_version="17-amazon-corretto-jdk"
    wout "installing java version: ${java_version}"
    wget -O- https://apt.corretto.aws/corretto.key | apt-key add -
    add-apt-repository -y 'deb https://apt.corretto.aws stable main'
    apt-get install -y java-${java_version}
    wout "installed java version: ${java_version}"
fi
#
###########################################
# /java install
###########################################

###########################################
# maven install
###########################################
if is_installed mvn; then
    wout "mvn already install. version is: $(mvn --version)"
else
    maven_version="3.8.5"
    wout "installing maven version: ${maven_version}"
    wget -q https://mirrors.estointernet.in/apache/maven/maven-3/${maven_version}/binaries/apache-maven-${maven_version}-bin.tar.gz
    tar -xf apache-maven-${maven_version}-bin.tar.gz -C /opt
    M2_HOME="/opt/apache-maven-${maven_version}"
    ln -s $M2_HOME/bin/mvn /usr/bin/mvn

    wout "installed maven version: ${maven_version}"
fi
###########################################
# /maven install
###########################################


###########################################
# docker install
###########################################
if is_installed docker; then
    wout "docker is already installed"
else
    apt-get install -y apt-transport-https ca-certificates curl software-properties-common
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
    apt-cache policy docker-ce
    apt-get install -y docker-ce
    systemctl status docker
    wout "installed docker"
    wout "configuring docker"
    groupadd -f docker
    usermod -aG docker ${user}
    chown root:docker /var/run/docker.sock
    #chown "${user}":"${user}" /home/"${user}"/.docker -R
    #chmod g+rwx "/home/${user}/.docker" -R
    #newgrp docker

###########################################
# /docker install
###########################################



###########################################
# selenoid install
###########################################
if [ -x cm_linux_amd64 ] ; then
    wout "selenoid alread installed"
else
    selenoid_version="1.8.1"
    chrome_version="99.0"
    wout "installing selenoid UI version: ${selenoid_version}"
    wget -q https://github.com/aerokube/cm/releases/download/${selenoid_version}/cm_linux_amd64
    chmod +x cm_linux_amd64
    ./cm_linux_amd64 selenoid start --browsers "chrome:${chrome_version}"
fi

#
echo completed updates and installs
