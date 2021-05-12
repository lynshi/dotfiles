Collection of dotfiles and other setup scripts for setting up a new Linux machine. So far, I've only used this on [Windows Subsystem for Linux](https://docs.microsoft.com/en-us/windows/wsl/) on Ubuntu 18.04/20.04.

# Usage
`setup.sh` installs dependencies required for the Ansible playbooks to run before running said playbooks. All arguments passed to it are forwarded to the `ansible-playbook` command.

## Example
```
./setup.sh -i hosts.yaml core.yaml git.yaml azure.yaml go.yaml python.yaml node.yaml --extra-vars "git_email=<your Git email>"
```
The `-i hosts.yaml` option [runs the playbook on localhost without warnings](https://github.com/ansible/ansible/issues/33132#issuecomment-363908285).

## Warning
You may have to restart your shell to get `virtualenvwrapper` to detect `virtualenv` properly. I haven't had time to debug this :/

## Git setup
The ansible playbook `git.yaml` installs [Git Credential Manager Core](https://github.com/microsoft/Git-Credential-Manager-Core),
a utility for managing GitHub and Azure DevOps credentials to connect via HTTPS instead of SSH. A
version is hardcoded in the playbook, so please find the latest release [here](https://github.com/microsoft/Git-Credential-Manager-Core/releases/latest). I also install [`pass`](https://www.passwordstore.org/) to use as the credential store for GCM Core, since I expect to
be on WSL which has no GUI. This also means I set `GPG_TTY`. See the [GCM Core documentation](https://github.com/microsoft/Git-Credential-Manager-Core/blob/master/docs/linuxcredstores.md) for further details.

[Additional setup is required for Git Credential Manager Core](https://github.com/microsoft/Git-Credential-Manager-Core/blob/master/docs/linuxcredstores.md#2-gpgpass-compatible-files) that seems easier to do manually.
1. Generate a GPG key: `gpg --gen-key`.
2. Initialize the credential store with `pass init <gpg-key-id>`. If you are having trouble determining
the GPG key id, please see these [GitHub docs](https://docs.github.com/en/github/authenticating-to-github/generating-a-new-gpg-key)
for more information.
3. GCM Core seems to have trouble writing to `.gitconfig` correctly. If there is a problem, an error will be printed on `git push` and you'll be asked for your GitHub credentials. You may need to do this to get it to work.
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
  when authenticating to repositories. Other errors are also possible depending on the version of GCM Core.
