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

# Shit To Do on New Linux Build
I have a desktop that runs Windows 11 with WSL. I can also boot it into Linux with a drive bay where I can swap the SSD. I have a couple of laptops, too. One of them is dedicated to Linux. I also have access to a couple of virtual servers. Finally, I have a pair of Raspberry Pi machines I laughingly call *servers*. All running Linux, yet all looking different. I want them to be the same. I want it to be familiar every time I shell into a machine or fire up a terminal. So, after 25 years of running Linux, I am finally trying to get organized and make sense of things.

Behold, the fruits of my labor. Please excuse the dust. *And mind the gap.*

## SSH SETUP
- Set up SSH keys for secure passwordless SSH logins
- create or import your `~/.ssh/id_rsa.pub`
- edit `~/.ssh/ssh_config`
- edit `/etc/ssh/sshd_config` to harden security
  - Change port
  - Tailscale IP address

## INSTALL APT PACKAGES
- git
- yadm    *(dotfile manager)*
- wget
- curl
- micro
- ranger
- mc      *(Midnight Commander)*
- btop
- htop
- tmux    *(terminal miultiplexer)*
- golang
- python-pip
- nodejs
- yarn
- docker
- docker-compose
- build-essential
- gcc
- make
- trash-cli
- thefuck
- 7zip
- exa
- unrar
- unzip

## DOTFILES IN GITHUB
Once `yadm` is installed, common dotfiles are available in a [private Github repo](https://github.com/davefl67/dotfiles)

## OTHER PACKAGES

- [tailscale](https://tailscale.com/download/linux)
- [moar](https://github.com/walles/moar/releases/latest)
- [lazydocker](https://github.com/jesseduffield/lazydocker/releases/latest)
- [lazygit](https://github.com/jesseduffield/lazygit/releases/latest)
- [ctop](https://github.com/bcicen/ctop/releases)
- [rust](https://www.rust-lang.org/tools/install)

## STARSHIP PROMPT
Install the [Starship prompt](https://starship.rs/#quick-install) for some colorful fun at the command line. Be sure also to copy or setup `~/.config/starship.toml` from the existing [dotfiles](https://github.com/davefl67/dotfiles). You will also need to install at least one [Nerd font](https://www.nerdfonts.com) to be able to see the glyphs, ligatures, and other cool shit. Download and copy font files into `~/.local/share/fonts` for a single user or `~/usr/local/share/fonts` for global use.

## TWEAK AND EDIT TO SUIT
- `~/.bashrc`
- `~/.bash_aliases`
- `~/.profile`
- `~/.tmux.conf`

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
  - `dave  ALL=(A::) NOPASSWD:ALL`
  - Log -dave- out of all sesions
  - Log in again