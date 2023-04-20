#!/usr/bin/env bash
set -x
set -e

abc="/home/main/Desktop/vagrant/abc-project"
xyz="/home/main/Desktop/vagrant/xyz-project"

repoRoot=$(realpath "$(dirname "$0")")

cd "$repoRoot"

## sh "./run.sh '${component}'" 


COMPONENT="$1"
if [[ -z "$COMPONENT" ]]; then
    echo "COMPONENT is not set"
    exit 1
fi

case "$COMPONENT" in
abc)
    mkdir -p $abc
    cd $abc
    curl -o Vagrantfile https://raw.githubusercontent.com/shivangiverma369/vagrant-public/main/abc/Vagrantfile
    vagrant up
    ;;
abc_clean-up)
    cd $abc
    vagrant halt && vagrant destroy -f
    ;;
xyz)
    mkdir -p $xyz
    cd $xyz
    curl -o Vagrantfile https://raw.githubusercontent.com/shivangiverma369/vagrant-public/main/xyz/Vagrantfile
    vagrant up
    ;;
xyz_clean-up)
    cd $xyz
    vagrant halt && vagrant destroy -f
    ;;
reset-abc)
    cd $abc
    vagrant halt && vagrant destroy -f 
    vagrant up
   ;;
reset-xyz)
    cd $xyz
    vagrant halt && vagrant destroy -f 
    vagrant up
   ;;         
*) ;;
esac
