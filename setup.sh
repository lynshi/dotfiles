#!/bin/bash
# Sets up some common packages and configuration.
# All arguments passed to this script are passed to `ansible-playbook`.
# For example, `./setup.sh python.yaml` eventually runs `ansible-playbook python.yaml`.

# For coloring terminal output.
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0;0m' # no color

set -e
function end_setup {
    echo -e "${RED}Set up failed.${NC}"
    exit 1
}
trap end_setup ERR

echo -e "${BLUE}Updating packages...${NC}"
sudo apt update && \
    sudo apt upgrade -y

codename=$(lsb_release -cs)
echo -e "${BLUE}Distribution codename: ${codename}${NC}"
if [ "$codename" = "bionic" ]; then
    echo -e "${BLUE}Adding Ansible PPA for Ansible 2.9+ (required for 'ansible-galaxy collection')${NC}"
    sudo apt install -y software-properties-common
    sudo apt-add-repository -y ppa:ansible/ansible
    sudo apt update
fi

echo -e "${BLUE}Installing ansible...${NC}"
sudo apt install -y ansible

echo -e "${BLUE}Installing ansible plugins...${NC}"
ansible-galaxy collection install community.general

echo -e "${BLUE}Running playbooks...${NC}"
ansible-playbook "$@"

echo -e "${GREEN}Done setting up! Please run \"source ~/.bashrc\" to complete setup.${NC}"
