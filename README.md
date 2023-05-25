Collection of dotfiles and other setup scripts for setting up a new Linux machine. Last used for  [Windows Subsystem for Linux (WSL)](https://docs.microsoft.com/en-us/windows/wsl/) on Ubuntu 22.04.

# Usage
`setup.sh` installs dependencies required for the Ansible playbooks to run before running said playbooks. All arguments passed to it are forwarded to the `ansible-playbook` command.

## Example
```
./setup.sh -i hosts.yaml core.yaml git.yaml azure.yaml go.yaml python.yaml node.yaml --extra-vars "git_email='${yourGitEmail}' git_name='${yourName}'"
```
The `-i hosts.yaml` option [runs the playbook on localhost without warnings](https://github.com/ansible/ansible/issues/33132#issuecomment-363908285).

## Warning
You may have to restart your shell to get `virtualenvwrapper` to detect `virtualenv` properly. I haven't had time to debug this :/

## Git setup
WARNING! Do not use `gcm.yaml` with WSL. See the section below.

The ansible playbook `gcm.yaml` installs [Git Credential Manager](https://github.com/GitCredentialManager/git-credential-manager),
a utility for managing GitHub and Azure DevOps credentials to connect via HTTPS instead of SSH. A
version is hardcoded in the playbook, so please find the latest release [here](https://github.com/microsoft/Git-Credential-Manager-Core/releases/latest). I also install [`pass`](https://www.passwordstore.org/) to use as the credential store for GCM Core. See the [GCM documentation](https://github.com/GitCredentialManager/git-credential-manager/blob/793a74cd540fb6030e2c7ee5e204f37a5f2a20d3/docs/credstores.md#gpgpass-compatible-files) for further details.

Once `gpg` and `pass` are installed, the following steps (lifted from the linked documentation) may be taken.
1. Generate a GPG key: `gpg --gen-key`.
2. Initialize the credential store with `pass init <gpg-key-id>`. If you are having trouble determining
the GPG key id, please see these [GitHub docs](https://docs.github.com/en/github/authenticating-to-github/generating-a-new-gpg-key)
for more information.

### Possible errors.
1. Git Credential Manager seems to have trouble writing to `.gitconfig` correctly. If there is a problem, an error will be printed on `git push` and you'll be asked for your GitHub credentials. You may need to do this to get it to work.
    1. `which git-credential-manager-core` to find out where the executable is.
    2. Open `~/.gitconfig`.
    3. Change `credential.helper` to `<path to git-credential-manager-core>`, for example,
  ```
  helper = /usr/bin/git-credential-manager-core
  ```
  If you don't do this, you could get something like
  ```
  helper = /var/tmp/.net/<username>/git-credential-manager-core/unqypyc0.awl/git-credential-manager-core
  ```
  in your `.gitconfig`, which will result in an error like
  ```
  git-credential-manager-core/unqypyc0.awl/git-credential-manager-core: not found
  ```
  when authenticating to repositories.
2. [Version 2.0.605 (the latest version at time of writing) does not set the symlink correctly in `/usr/local/bin`.](https://github.com/GitCredentialManager/git-credential-manager/issues/570)

### Windows Subsystem for Linux
On WSL, you should install Git for Windows on Windows and use `gcm-wsl.yaml` to update `.gitconfig` to use Git for Windows for authentication. You can find the latest docs [here](https://github.com/GitCredentialManager/git-credential-manager/blob/main/docs/wsl.md#windows-subsystem-for-linux-wsl).
