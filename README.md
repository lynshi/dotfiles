Collection of dotfiles and other setup scripts for setting up a new Linux machine.

# Tested environments
- Ubuntu 22.04
- MacOS (M1)

# Usage
`setup.sh` installs dependencies required for the Ansible playbooks to run before running said playbooks. All arguments passed to it are forwarded to the `ansible-playbook` command.

`mac-setup.sh` does the same thing but for Mac.

To change the version of things to install, update the versions in `vars/versions.yaml`.

## Example
```bash
yourGitEmail=""
yourName=""

# Linux
./setup.sh -i hosts.yaml azure.yaml core.yaml dotnet.yaml git.yaml go.yaml node.yaml python.yaml --extra-vars "git_email='${yourGitEmail}' git_name='${yourName}'"

# Mac
./mac-setup.sh -i hosts.yaml azure.yaml core.yaml dotnet.yaml git.yaml go.yaml node.yaml python.yaml --extra-vars "git_email='${yourGitEmail}' git_name='${yourName}'"
```
The `-i hosts.yaml` option [runs the playbook on localhost without warnings](https://github.com/ansible/ansible/issues/33132#issuecomment-363908285).

Optionally, add any `gcm-*.yaml` after reading the section below.

## Warning
You may have to restart your shell to get `virtualenvwrapper` to detect `virtualenv` properly. I haven't had time to debug this :/

## Git Credential Manager setup

### Windows Subsystem for Linux
On WSL, you should install Git for Windows on Windows and use `gcm-wsl.yaml` to update `.gitconfig` to use Git for Windows for authentication. You can find the latest docs [here](https://github.com/GitCredentialManager/git-credential-manager/blob/main/docs/wsl.md#windows-subsystem-for-linux-wsl).
