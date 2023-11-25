#!/bin/zsh
# Sets up some common packages and configuration.
# All arguments passed to this script are passed to `ansible-playbook`.
# For example, `./setup.sh python.yaml` eventually runs `ansible-playbook python.yaml`.

# For coloring terminal output.
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0;0m' # no color

xcode_installed=$(xcode-select -p &>/dev/null; echo $?)
if [ $xcode_installed -ne 0 ]; then
    echo -e "${RED}Please install XCode from the App Store!${NC}"
    exit 1
fi

brew_installed=$(brew -v &>/dev/null; echo $?)
if [ $brew_installed -ne 0 ]; then
    echo -e "${RED}Please install brew: https://github.com/Homebrew/brew/releases/latest${NC}"
    exit 1
fi

set -e

echo -e "${BLUE}Updating packages...${NC}"
brew update

brew_python_present=$(brew list python3 &>/dev/null; echo $?)
if [ $brew_python_present -ne 0 ]; then
    echo -e "${BLUE}Installing Python 3.11 via brew...${NC}"
    brew install python@3.11

    echo -e "${RED}Please restart your terminal for the brew-installed Python to take effect...${NC}"
    exit 0
fi

if ! python3 -m pip -V; then
    echo -e "${RED}'pip' not installed, aborting!${NC}"
    exit 1
fi

echo -e "${BLUE}Installing ansible via pip...${NC}"
python3 -m pip install --user ansible

echo -e "${BLUE}Adding ${HOME}/Library/Python/3.11/bin to PATH...${NC}"
export PATH="${PATH}:${HOME}/Library/Python/3.11/bin"

echo -e "${BLUE}Installing ansible plugins...${NC}"
ansible-galaxy collection install community.general

echo -e "${BLUE}Installing gnu-tar (required by ansible)...${NC}"
brew install gnu-tar

echo -e "${BLUE}Running playbooks...${NC}"
ansible-playbook "$@"

echo -e "${GREEN}Done setting up! If there are no failed ansible tasks above, run \"source ~/.zshrc\" to complete setup.${NC}"
