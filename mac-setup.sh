#!/bin/zsh
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
brew update

if ! python3 -m pip -V; then
    echo -e "${RED}'pip' not installed, aborting!${NC}"
    exit 1
fi

echo -e "${BLUE}Installing ansible via pip...${NC}"
python3 -m pip install --user ansible

echo -e "${BLUE}Adding $HOME/.local/bin to PATH...${NC}"
export PATH=${PATH}:${HOME}/.local/bin

echo -e "${BLUE}Installing ansible plugins...${NC}"
ansible-galaxy collection install community.general

echo -e "${BLUE}Running playbooks...${NC}"
ansible-playbook "$@"

echo -e "${GREEN}Done setting up! Please run \"source ~/.zshrc\" to complete setup.${NC}"
