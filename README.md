Collection of dotfiles and other setup scripts for setting up a new Linux machine. Last used for  [Windows Subsystem for Linux (WSL)](https://docs.microsoft.com/en-us/windows/wsl/) on Ubuntu 22.04.

# Usage
`setup.sh` installs dependencies required for the Ansible playbooks to run before running said playbooks. All arguments passed to it are forwarded to the `ansible-playbook` command.

## Example
```
./setup.sh -i hosts.yaml core.yaml git.yaml azure.yaml dotnet.yaml go.yaml python.yaml node.yaml --extra-vars "git_email='${yourGitEmail}' git_name='${yourName}'"
```
The `-i hosts.yaml` option [runs the playbook on localhost without warnings](https://github.com/ansible/ansible/issues/33132#issuecomment-363908285).

Optionally, add `gcm-wsl.yaml` after reading the section below.

## Warning
You may have to restart your shell to get `virtualenvwrapper` to detect `virtualenv` properly. I haven't had time to debug this :/

## Git Credential Manager setup
Nowadays, the only environment where special setup seems to be needed is WSL, so there is no automation for any other environment.

### Windows Subsystem for Linux
On WSL, you should install Git for Windows on Windows and use `gcm-wsl.yaml` to update `.gitconfig` to use Git for Windows for authentication. You can find the latest docs [here](https://github.com/GitCredentialManager/git-credential-manager/blob/main/docs/wsl.md#windows-subsystem-for-linux-wsl).

## Go
Go is installed via a package file on Mac, so is omitted from automation.
