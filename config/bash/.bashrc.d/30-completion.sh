# 30-completion.sh — bash completion + binds + tool completions

# shopt goodies
shopt -s autocd
shopt -s cdspell
shopt -s cmdhist
shopt -s dotglob
shopt -s expand_aliases

# TAB completion ignores case
bind "set completion-ignore-case on"

# bash-completion
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# treemd completion (only if command exists)
if command -v treemd >/dev/null 2>&1; then
  source <(COMPLETE=bash treemd)
fi

# lla completion (if present)
[ -r "$HOME/.lla-completion.bash" ] && . "$HOME/.lla-completion.bash"
