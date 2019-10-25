#!/bin/bash

function pre_install() {
  sudo yum update -y
  sudo yum install -y unzip curl
}

function install_kops() {
  if [ -z $(which kops) ]; then
    local kops_version='1.14.0'
    local kops_package='kops-linux-amd64'
    curl -Lo kops https://github.com/kubernetes/kops/releases/download/${kops_version}/${kops_package}
    chmod +x ./kops
    sudo mv ./kops /usr/local/bin/
  else
    echo "kops is most likely installed"
  fi
}

function install_kubectl() {
  if [ -z $(which kubectl) ]; then
    curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
    chmod +x ./kubectl
    sudo mv ./kubectl /usr/local/bin/kubectl
  else
    echo "kubectl is most likely installed"
  fi
}

function install_terraform() {
  if [ -z $(which terraform) ]; then
    local terraform_version='0.12.12'
    local terraform_package='terraform_0.12.12_linux_amd64.zip'

    wget https://releases.hashicorp.com/terraform/${terraform_version}/${terraform_package}
    unzip $terraform_package
    sudo mv terraform /usr/local/bin/terraform
    rm -rf $terraform_package
  else
    echo "terraform is most likely installed"
  fi
}

function install_docker() {
  if [ -z $(which docker) ]; then
    sudo yum install -y yum-utils \
    device-mapper-persistent-data \
    lvm2
    sudo yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo
    sudo yum install -y docker-ce docker-ce-cli containerd.io
    sudo systemctl start docker
    sudo usermod -aG docker $USER
  else
    echo "Docker is most likely installed"
  fi
}

function install_nodejs() {
    if [ -z $(wich npm) ]; then
        curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.0/install.sh | bash
        export NVM_DIR="$HOME/.nvm"
        [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
        [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
        nvm install --lts
        nvm use --lts
        
        curl -o- -L https://yarnpkg.com/install.sh | bash
        export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
    else
        echo "NodeJs is most likely installed"
    fi
}

pre_install
install_kops
install_kubectl
install_terraform
install_docker
install_nodejs
