Collection of dotfiles and other setup scripts for setting up a new Linux machine.

# Usage
`setup.sh` installs dependencies required for the Ansible playbooks to run before running them. All arguments passed to it are forwarded to the `ansible-playbook` command.
```
./setup.sh -i hosts.yaml core.yaml azure.yaml go.yaml python.yaml node.yaml
```
The `-i hosts.yaml` option [runs the playbook on localhost without warnings](https://github.com/ansible/ansible/issues/33132#issuecomment-363908285).

## Warning
You may have to restart your shell to get `virtualenvwrapper` to detect `virtualenv` properly. I haven't had time to debug this :/