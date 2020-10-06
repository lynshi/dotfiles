#!/bin/bash
# Sets up some default configuration options. Last used on Ubuntu 20.04.
# For coloring terminal output.
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0;0m'  # no color

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
echo -e "${BLUE}Setup script located in ${SCRIPT_DIR}${NC}"

CWD=$(pwd)
if [ "$CWD" != "$SCRIPT_DIR" ]; then
    echo -e "${RED}Current directory is ${CWD}. Please go to ${SCRIPT_DIR} to run the script.${NC}"
    exit 1
fi

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
ansible-playbook "$@"

echo -e "${BLUE}Updating ~/.bashrc for new programs${NC}"
cat "${SCRIPT_DIR}/.bashrc" >> ~/.bashrc

echo -e "${BLUE}Configuring vim${NC}"
rm ~/.vimrc
cp "${SCRIPT_DIR}/.vimrc" ~/.vimrc

echo -e "${BLUE}Configuring git${NC}"
git config --global core.editor "vim"
git config --global user.name "Lyndon Shi"
git config --global user.email "shilyndon@gmail.com"

echo -e "${GREEN}Done setting up! Please run \"source ~/.bashrc\" to complete setup"
