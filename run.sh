#!/usr/bin/env bash
set -x
set -e

ubuntu="/home/main/Desktop/vagrant/ubuntu"
redhat="/home/main/Desktop/vagrant/redhat"

repoRoot=$(realpath "$(dirname "$0")")

cd "$repoRoot"

## sh "./run.sh '${component}'" 


COMPONENT="$1"
if [[ -z "$COMPONENT" ]]; then
    echo "COMPONENT is not set"
    exit 1
fi

case "$COMPONENT" in
ubuntu)
    mkdir -p $ubuntu
    cd $ubuntu
    curl -o Vagrantfile https://raw.githubusercontent.com/shivangiverma369/vagrant-public/main/ubuntu/Vagrantfile
    vagrant up
    ;;
ubuntu_clean-up)
    cd $ubuntu
    vagrant halt && vagrant destroy -f
    ;;
redhat)
    mkdir -p $redhat
    cd $redhat
    curl -o Vagrantfile https://raw.githubusercontent.com/shivangiverma369/vagrant-public/main/redhat/Vagrantfile
    vagrant up
    ;;
redhat_clean-up)
    cd $redhat
    vagrant halt && vagrant destroy -f
    ;;
reset-ubuntu)
    cd $ubuntu
    vagrant halt && vagrant destroy -f 
    vagrant up
   ;;
reset-redhat)
    cd $redhat
    vagrant halt && vagrant destroy -f 
    vagrant up
   ;;         
*) ;;
esac
