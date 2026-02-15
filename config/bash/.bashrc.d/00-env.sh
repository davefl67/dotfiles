# 00-env.sh — interactive environment defaults (no secrets, no TERM)

# Language
export LC_ALL="en_US.UTF-8"
export LANG="en_US.UTF-8"
export LANGUAGE="en_US.UTF-8"

# History
export HISTCONTROL="ignoreboth"
shopt -s histappend
shopt -s checkwinsize

# Lesspipe
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# GCC colors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Less colors (man pages)
export LESS_TERMCAP_mb=$'\e[01;31m'
export LESS_TERMCAP_md=$'\e[01;38;5;74m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[38;5;246m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[04;38;5;146m'

# Editors / pagers
export EDITOR="/usr/bin/micro"
export VISUAL="/usr/bin/micro"
export VISUDO="/usr/bin/micro"

# Prefer less as the system pager; moar will be aliased in 10-aliases.sh
export PAGER="less -FRX"
export VIEWER="$PAGER"

# Moar defaults (used if you alias to moar)
export MOAR="--statusbar=inverse --no-linenumbers"

# Terminal niceties (do NOT override TERM here)
export MICRO_TRUECOLOR=1
export COLORTERM="truecolor"

# Manpager via bat (Debian uses batcat)
export MANROFFOPT="-c"
export MANPAGER="sh -c 'col -bx | batcat -l man -p'"
