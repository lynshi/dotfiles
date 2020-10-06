#!/bin/bash
# Sets up some common packages and configuration. Last used on Ubuntu 20.04.

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

echo -e "${BLUE}Installing ansible and running playbooks...${NC}"
sudo apt install -y ansible

echo -e "${BLUE}Installing ansible plugins...${NC}"
ansible-galaxy collection install community.general

echo -e "${BLUE}Running playbooks...${NC}"
ansible-playbook "$@"

echo -e "${GREEN}Done setting up! Please run \"source ~/.bashrc\" to complete setup.${NC}"
