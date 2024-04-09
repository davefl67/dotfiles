
# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# language settings
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Less Colors for Man Pages
export LESS_TERMCAP_mb=$'\e[01;31m'       # begin blinking
export LESS_TERMCAP_md=$'\e[01;38;5;74m'  # begin bold
export LESS_TERMCAP_me=$'\e[0m'           # end mode
export LESS_TERMCAP_se=$'\e[0m'           # end standout-mode
export LESS_TERMCAP_so=$'\e[38;5;246m'    # begin standout-mode - info box
export LESS_TERMCAP_ue=$'\e[0m'           # end underline
export LESS_TERMCAP_us=$'\e[04;38;5;146m' # begin underline

### editors, pagers, etc

export MOAR='--statusbar=inverse --no-linenumbers'
export PAGER='/usr/local/bin/moar'
export VIEWER='/usr/local/bin/moar'
export EDITOR='/usr/bin/micro'
export VISUDO='/usr/bin/micro'
export TERM='xterm-256color'
export BROWSER='/usr/bin/lynx'
export MICRO_TRUECOLOR=1
export COLORTERM='truecolor'

# na na na na na na na na BAT man
export MANROFFOPT="-c"
export MANPAGER="sh -c 'col -bx | batcat -l man -p'"

# editor replacements
alias nano="micro"
alias vi="nano"

# pager replacements
alias less="moar"
alias most="moar"
alias more="moar"

# LAZYDOCKER
alias lzd='lazydocker'

# BAT for CAT
alias cat='batcat -p'
alias bat='batcat'

# Changing "ls" to "exa"
unalias l > /dev/null 2>&1
alias ll='echo " " && exa -aalghSb@ --color=always --icons --group-directories-first && echo " "'
alias la='echo " " && exa -1a --color=always --icons --group-directories-first && echo " "'
alias ls='echo " " && exa -lah --color=always --icons --group-directories-first && echo " "'
alias ls='echo " " && exa -lah --color=always --icons --group-directories-first'
alias lt='echo " " && exa -aT --color=always --icons --group-directories-first && echo " "'
alias l.='echo " " && exa -a | egrep "^\."'

### TRASH-CLI
# Instead of rm, which deletes files permanently, we will use trash-cli
# (github.com/andreafrancia/trash-cli) which moves files to system trash.
alias tp='trash-put'
alias rm='trash-put'

# confirm before overwriting something
alias cp="cp -i"
alias mv='mv -i'

# Midnight Commander
alias mc='/usr/lib/mc/mc-wrapper.sh'

# adding flags
alias df='df -h'                          # human-readable sizes
alias free='free -m'                      # show sizes in MB
alias lynx='lynx -cfg=~/.lynx/lynx.cfg -lss=~/.lynx/lynx.lss -vikeys'

# ps
alias psa="ps auxf"
alias psgrep="ps aux | grep -v grep | grep -i -e VSZ -e"
alias psmem='ps auxf | sort -nr -k 4'
alias pscpu='ps auxf | sort -nr -k 3'

# ssh shortcuts
alias hades='ssh davefl67@hades.usbx.me'
alias eof='ssh dave@100.86.3.59 -p 25309'
# alias howard='ssh dietpi@10.0.0.205'
# alias leonard='ssh dave@10.0.0.105'
# alias barry='ssh dietpi@10.0.0.210'

# git
alias addup='git add -u'
alias addall='git add .'
alias branch='git branch'
alias checkout='git checkout'
alias clone='git clone'
alias commit='git commit -m'
alias fetch='git fetch'
alias pull='git pull origin'
alias push='git push origin'
alias stat='git status'  # 'status' is protected name so using 'stat' instead
alias tag='git tag'
alias newtag='git tag -a'

# bare git repo alias for dotfiles
alias config="/usr/bin/git --git-dir=$HOME/.cfg --work-tree=$HOME"

# the terminal rickroll
# alias rr='curl -s -L https://raw.githubusercontent.com/keroserene/rickrollrc/master/roll.sh | bash'

# termbin
alias tb="nc termbin.com 9999"

# get error messages from journalctl
alias jctl="journalctl -p 3 -xb"

# gpg encryption
# verify signature for isos
alias gpg-check="gpg2 --keyserver-options auto-key-retrieve --verify"
# receive the key of a developer
alias gpg-retrieve="gpg2 --keyserver-options auto-key-retrieve --receive-keys"

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

### SHOPT
shopt -s autocd # change to named directory
shopt -s cdspell # autocorrects cd misspellings
shopt -s cmdhist # save multi-line commands in history as single line
shopt -s dotglob
shopt -s expand_aliases # expand aliases

#ignore upper and lowercase when TAB completion
bind "set completion-ignore-case on"

### ARCHIVE EXTRACTION
# usage: ex <file>
ex ()
{
  if [ -f "$1" ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1   ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *.deb)       ar x $1      ;;
      *.tar.xz)    tar xf $1    ;;
      *.tar.zst)   unzstd $1    ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# navigation
up () {
  local d=""
  local limit="$1"

  # Default to limit of 1
  if [ -z "$limit" ] || [ "$limit" -le 0 ]; then
    limit=1
  fi

  for ((i=1;i<=limit;i++)); do
    d="../$d"
  done

  # perform cd. Show error if cd fails
  if ! cd "$d"; then
    echo "Couldn't go up $limit dirs.";
  fi
}

### BASH INSULTER ###
if [ -f /etc/bash.command-not-found-messages ]; then
    . /etc/bash.command-not-found-messages
fi

if [ -f /etc/bash.command-not-found ]; then
    . /etc/bash.command-not-found
fi

### GOLANG STUFF ###
# export GOROOT=/usr/local/go
# export GOPATH=$HOME/go
# export PATH=$GOPATH/bin:$GOROOT/bin:$PATH

### TAILSCALE IP4 TO ENV VARIABLE ###
export TAIL4="$(/sbin/ip address show dev tailscale0 | grep 'inet 1' | cut -c 10-23)"

### SETTING THE STARSHIP PROMPT ##
eval "$(starship init bash)"

### WHAT THE FUCK?? ###
eval "$(thefuck --alias)"

### RUST ###
. "$HOME/.cargo/env"

### PFETCH & FIGLET
PF_COLOR=1
clear
figlet -f slant $HOSTNAME
pfetch

########### EOF ###########
