# MY DOTFILES AND BASIC SERVER SETUP
*Let it be known, I have **no** fucking idea what I am doing.*

I have been using Linux for 25 years. In all this time, I made no attempt to organize and backup my **.dotfiles** or standardize installation of new machines. 

I have installed a Great Number™ of machines in my time. If I am successful with this repository, I will not have to completely rebuild my Linux environment from my addled memory every time I blow up a computer and reinstall.  *This happens quite frequently.*

To add to my general confusion, and to generally make things more complicated, I am teaching myself some other new things. This is in addition to learning how to use [yadm](https://yadm.io/) and **git** to manage my dotfiles.
- I am learning Lua
- I am learning how to code for a FiveM server
- I am learning Markdown
- I am learning **VS Code Server**

This is all at the same time. *I think my head is about to explode.* 
That is what happens when you're 55 years old and don't have a clue what you're doing.

I hope these notes help someone.

# MY SHIT
I have a desktop that runs Windows 11 with WSL. I can also boot it into Linux with a drive bay where I can swap the SSD. I have a couple of laptops, too. One of them is running an Manjaro variant called [Mabox Linux](https://maboxlinux.org). I also have access to a couple of virtual servers. Finally, I have a pair of Raspberry Pi machines I laughingly call *servers*. All running Linux, yet all looking different. I want them to be the same. I want it to be familiar every time I shell into a machine or fire up a terminal. So, after 25 years of running Linux, I am finally trying to get organized and make sense of things.

## THESE INSTRUCTIONS ARE FOR DEBIAN

It's possible they will also work on Debian derivitives. They may also work for Ubuntu servers. These are for **sever builds** and not desktops. I have neither packages listed nor instructions given for setting up a GUI working environment. So neither window manager nor desktop environment. If you are using my notes, you're on your own there. Behold, the fruits of my labor. Please excuse the dust. *And mind the gap.*

## INSTALLING THE OPERATING SYSTEM
Yep. You're on your own here, too. Just follow the installer and log in for the first time. Make sure you create a non-root **$USER** account, that's where we'lll be working mostly. 

## SSH SETUP
Once you are logged in, you will want to set upa way tòremotely log in to your server. Unless, of course, your server has a keyboard and monitor and you will only be working on it locally. If that's the case, you can skip this part. Most sensible servers are run **headless** and need to be secured for remote logins by users in other locations. Sometimes people from all over the globe. **sshd** is usually instaled by default. If not, make sure you install the **openssh-server** package.

### Passwordless Secure Shell
- Generate SSH keys for secure passwordless SSH logins using the command `ssh-keygen -t rsa -b 4096`. Be sure to generate a password for this key.
- The private key (your identification) will be save in the `~/.ssh/id_rsa` file under your home directory.
- The public key will be save in the `~/.ssh/id_rsa.pub` file.
- Upload your key to the host with the command `ssh-copy-id -i ~/.ssh/id_rsa <user>@server-ip`
- Login to the remote server with the command `ssh <user>@server-ip`. You should be prompted for the password you generated for the key.
- Once you are logged in, you can log out and test the key. Type `exit`
- Log in once again `ssh <user>@server-ip`

If everything works, you can now log in with no password required for this server.

## SSH SETUP FOR GITHUB LOGINS
Create and upload an SSH key to Github. Once the key is on file, you can edit the `~/.ssh/config` to have the key used for passwordless logons. Add the following.
```
Host github.com
  User git@github.com
  IdentityFile ~/.ssh/davefl67_rsa
  ForwardAgent yes
  PubkeyAuthentication yes
```
  To test the login, you will need to have the SSH Agent running. You should add a command to `~/.bashrc` The command is `eval "$(ssh-agent -s)"` and this will load the agent in the background. To test passwordless login, type this command: `ssh -vT git@github.com`

  When using git and are prompted for a user name, always use the generic user `git@github.com`. It will automatically use your SSH key and find your account. Check the [Github Docs](https://docs.github.com/en/authentication/troubleshooting-ssh/error-permission-denied-publickey) for troubleshooting assistance

## HARDEN SSHD SERVER SECURITY
You'll need to harden the server's **sshd** configuration to allow for passwordless logins only. There are a few other tips and tricks as well. You will want to edit `/etc/ssh/sshd_config` to harden security. At the very least, you should change the following.
- Change `Port` to something obscure higher than 2048
- Change `PasswordAuthentication` to **no**
- Change `ChallengeResponseAuthentication` to **no**
- Change `ListenAddress` from `0.0.0.0` to the ip address of a VPN tunnel or a Tailscale IP address. This allows connections only from that private network.

Once complete, restart the SSH server with the following command
`sudo systemctl restart ssh`

---
***NOTE:** I have some other tweaks, such as adding 2FA with a Google Authenticator. I've had some trouble with it. I'll add the procedure once I have it working.*

---

# INSTALL APT PACKAGES
These are the bare necessities. May add more, so check back. They are installed with Debian's `apt` package manager.

| Package | Description |
| ---- | ----- |
yadm  | Dotfile manager
wget  | File getter
curl  | File getter
micro | CLI Text Editor
bat   | CLI Pager
figlet | Make ASCII word art
ranger | CLI File Manager
mc    | Midnight Commander
build-essential | Essential files to compile code
gcc | Compiler
make | Builds makefiles
btop | System monitor
htop | System monitor
tmux | Terminal miultiplexer
golang | Go programming language
python3 | Python programming language
python3-pip | Package installer for Python
nodejs | NodeJS programming language
npm | Package installer for NodeJS
yarn | Some code shit
docker.io | Docker containers
docker-compose | Run multiple containers in a stack
trash-cli | CLI Recycle bin
thefuck | Correct your fucking mistakes
p7zip | Compression algorithn
unrar-free | Compression algorithn
unzip | Compression algorithn
exa | Fancy replacement for `ls`
tldr | **tldr;** condensed `man` pages
cmatrix | *The Matrix* digital rain
---
## ADDING NONFREE AND CONTRIB REPOSITORIES
Debian only provides free (as in freedon) software by default. Other repositories without free licenses are available. To add these repositories:
1. `sudo apt update && sudo apt upgrade`
2. `sudo apt install software-properties-common -y`
3. `sudo apt-add-repository contrib non-free`

## DOTFILES IN GITHUB
Once [yadm](https://yadm.io) is installed, common dotfiles are available in a [private Github repo](https://github.com/davefl67/dotfiles). These files are backed up and synchronised using Git. That way all of the basic settings for all of my Linux machines are the same.
1. `yadm init`
2. `yadm clone -f`

## OTHER RESOURCES
This is stuff I use but that does not have a Debian package. The links have instalation instructions included.
- [tailscale](https://tailscale.com/download/linux)
- [pfetch](https://github.com/dylanaraps/pfetch/releases)
- [moar](https://github.com/walles/moar/releases/latest)
- [lazydocker](https://github.com/jesseduffield/lazydocker/releases/latest)
- [lazygit](https://github.com/jesseduffield/lazygit/releases/latest)
- [ctop](https://github.com/bcicen/ctop/releases)

## STARSHIP PROMPT
Install the [Starship prompt](https://starship.rs/#quick-install) for some colorful fun at the command line. Be sure also to copy or setup `~/.config/starship.toml` from the existing [dotfiles](https://github.com/davefl67/dotfiles). You will also need to install at least one [Nerd font](https://www.nerdfonts.com) to be able to see the glyphs, ligatures, and other cool shit. Download and copy font files into `~/.local/share/fonts` for a single user or `~/usr/local/share/fonts` for global use.

## TWEAK AND EDIT TO SUIT
Make sure your user is added to the **sudoers** group so that you can run commands as root when necessary֫. The command is `sudo usermod -aG sudo $USER`

Check over all of the **.dotfiles** in your **$HOME** directory. Some of the details include:
- `~/.bashrc`
- `~/.bash_aliases`
- `~/.profile`
- `~/.tmux.conf`

### Using YADM
Once you are satisfied with the setup of your **.dotfiles**, follow the directions for [yadm](https://yadm.io) to back up your dotfiles. You'll be glad you did, as a backup is always good. 

# DOCKER MAGIC
When installing Docker, you will need to add your user to the `docker` group to be able to run docker containers without sudo.
1. Run `sudo usermod -aG docker $USER`
2. Log out of your account
3. Log back in. Run `groups $USER` to verify membership

## PORTAINER
Once Docker is running on the new machine, the first package to install is either [Portainer](https://docs.portainer.io/start/install-ce/server/docker/linux) or [Portainer Agent](https://docs.portainer.io/admin/environments/add/docker/agent). 

If using Portainer Agent, this will be an *environment* linked to another Portainer instance. Once Portainer Agent is installed, add this machine to the Portainer installation on **PENNY**

## CLOUDFLARE
To allow zero-trust tunnel to access the containers on this machine, you will need to install the [cloudflared](https://hub.docker.com/r/cloudflare/cloudflared) container. Once running, you can access the Cloudflare website and set up hstnames to point to the web interfaces of your containers securely.

## WATCHTOWER
You'll need to install the [watchtower](https://hub.docker.com/r/containrrr/watchtower) container to keep all your containers running on the latest version.

### Other stuff to do
- link relevant .dotfiles to `/root` user folder

### Trash bin for CLI
Something to try is `trash-cli` which is a trash or recycle bin for the command line. 
  - [article in Tecmint](https://www.tecmint.com/trash-cli-manage-linux-trash-from-command-line/)
  - [article in MUO](https://www.makeuseof.com/trash-files-linux-command-line-trash-cli/)
- [about libtrash](https://pages.stern.nyu.edu/~marriaga/software/libtrash/)
- [using in mc](https://wiki.archlinux.org/title/Midnight_Commander#Using_libtrash)

### Is this WSL2?
-  [Read this](https://ubuntu.com/tutorials/install-ubuntu-on-wsl2-on-windows-11-with-gui-support)
- Enable systemd
- Enable graphical apps

### VNC
If this machine is to have a GUI desktop, set up a VNC server

### visudo
- Use visudo to eliminate sudo password
  - At the end of the `/etc/sudoers` file add:
  - `dave  ALL=(ALL) NOPASSWD:ALL`
  - Log -dave- out of all sesions
  - Log in again
