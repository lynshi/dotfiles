
# <Added by dotfiles setup>
PS1="\t $PS1" # Always show timestamp in case of WSL clock drift.

export WORKON_HOME=~/.virtualenv
export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
export VIRTUALENVWRAPPER_VIRTUALENV_ARGS='--no-site-packages'
source ~/.local/bin/virtualenvwrapper.sh

export PATH=$PATH:/usr/local/go/bin
# </Added by dotfiles setup>
