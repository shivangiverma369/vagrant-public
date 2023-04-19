#!/usr/bin/env bash
set -x
set -e

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
    mkdir -p "/home/main/Desktop/vagrant/ubuntu"
    cd "/home/main/Desktop/vagrant/ubuntu"
    curl -o Vagrantfile https://raw.githubusercontent.com/shivangiverma369/vagrant/main/ubuntu/Vagrantfile
    # https://raw.githubusercontent.com/ankursharma2725/jenkins-vagrant/main/Vagrantfile
#     curl -LJO https://github.com/ankursharma2725/jenkins-vagrant/main/Vagrantfile
#     sudo -u main vagrant up
#     chmod 777 Vagrantfile
    vagrant up
    ;;
ubuntu_clean-up)
    cd "/home/main/Desktop/vagrant"
    vagrant halt && vagrant destroy -f
    ;;
redhat)
    mkdir -p "/home/main/Desktop/vagrant/redhat"
    cd "/home/main/Desktop/vagrant/redhat"
    curl -o Vagrantfile https://raw.githubusercontent.com/shivangiverma369/vagrant/main/redhat/Vagrantfile
    vagrant up
    ;;
redhat_clean-up)
    cd "/home/main/Desktop/vagrant/redhat"
    vagrant halt && vagrant destroy -f
    ;;
reset-vm)
    mkdir "home/main/Desktop/vagrant/vagrant-reset"
    cd "/home/main/Desktop/vagrant/vagrant-reset"
    curl -o Vagrantfile https://raw.githubusercontent.com/shivangiverma369/vagrant/main/redhat/Vagrantfile
    vagrant up --vagrantfile vagrant-reset


    ;;
kibana)
    ansible-playbook -i environments/localhost/ --vault-password-file=~/.secrets/tass-ansible-vault deploy-kibana.yml --connection=local
    ;;
configurator)
    ansible-playbook -i environments/localhost/ --vault-password-file=~/.secrets/tass-ansible-vault deploy-configurator.yml --connection=local 
    ;;
heartbeat)
    ansible-playbook -i environments/localhost/ --vault-password-file=~/.secrets/tass-ansible-vault deploy-heartbeat.yml --connection=local 
    ;;
metricbeat)
    ansible-playbook -i environments/localhost/ --vault-password-file=~/.secrets/tass-ansible-vault deploy-metricbeat.yml --connection=local 
    ;;
filebeat)
    ansible-playbook -i environments/localhost/ --vault-password-file=~/.secrets/tass-ansible-vault deploy-filebeat.yml --connection=local 
    ;;
auditbeat)
    ansible-playbook -i environments/localhost/ --vault-password-file=~/.secrets/tass-ansible-vault deploy-auditbeat.yml --connection=local 
    ;;                         
kafka)
    ansible-playbook -i environments/localhost/ --vault-password-file=~/.secrets/tass-ansible-vault deploy-kafka.yml --connection=local 
    ;;
kafka-ui)
    ansible-playbook -i environments/localhost/ --vault-password-file=~/.secrets/tass-ansible-vault deploy-kafka-ui.yml --connection=local 
    ;;    
promethues)
    ansible-playbook -i environments/localhost/ --vault-password-file=~/.secrets/tass-ansible-vault deploy-promethues.yml --connection=local 
    ;;
grafana)
    ansible-playbook -i environments/localhost/ --vault-password-file=~/.secrets/tass-ansible-vault deploy-grafana.yml --connection=local 
    ;;
jenkins)
    ansible-playbook -i environments/localhost/ --vault-password-file=~/.secrets/tass-ansible-vault deploy-jenkins.yml --connection=local 
    ;;             
*) ;;
esac
