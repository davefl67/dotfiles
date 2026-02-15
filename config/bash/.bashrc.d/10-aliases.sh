# 10-aliases.sh — aliases + safe rm wrapper

# Editor replacements
alias nano='/usr/bin/micro'
alias vi='/usr/bin/micro'

# Pager replacements (optional comfort layer)
# Keep real less available via "command less"
if command -v moar >/dev/null 2>&1; then
  alias less='moar'
  alias most='moar'
  alias more='moar'
fi

# BAT for CAT (Debian uses batcat)
if command -v batcat >/dev/null 2>&1; then
  alias cat='batcat -p'
  alias bat='batcat'
fi

# Lazydocker
command -v lazydocker >/dev/null 2>&1 && alias lzd='lazydocker'

# Safer file ops
alias cp='cp -i'
alias mv='mv -i'

# Midnight Commander
[ -x /usr/lib/mc/mc-wrapper.sh ] && alias mc='/usr/lib/mc/mc-wrapper.sh'

# Common flags
alias df='df -h'
alias free='free -m'

# ps helpers
alias psa='ps auxf'
alias psmem='ps auxf | sort -nr -k 4'
alias pscpu='ps auxf | sort -nr -k 3'

# journalctl errors
alias jctl='journalctl -p 3 -xb'

# termbin
alias tb='nc termbin.com 9999'

# GPG helpers
alias gpg-check='gpg2 --keyserver-options auto-key-retrieve --verify'
alias gpg-retrieve='gpg2 --keyserver-options auto-key-retrieve --receive-keys'

# Rickroll (keep if you like it 😄)
alias rr='curl -s -L https://raw.githubusercontent.com/keroserene/rickrollrc/master/roll.sh | bash'

# TRASH-CLI: make rm safe by default, but preserve flags behavior
trash() {
  if [[ "$1" == -* ]]; then
    command rm "$@"
  else
    command -v trash-put >/dev/null 2>&1 && trash-put "$@" || command rm -i "$@"
  fi
}
alias rm='trash'
alias tp='trash-put'
alias rmp='command rm -i'
