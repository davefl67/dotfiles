# 20-functions.sh — helper functions

# Archive extraction: ex <file>
ex () {
  if [ -f "$1" ] ; then
    case $1 in
      *.tar.bz2)   tar xjf "$1"   ;;
      *.tar.gz)    tar xzf "$1"   ;;
      *.bz2)       bunzip2 "$1"   ;;
      *.rar)       unrar x "$1"   ;;
      *.gz)        gunzip "$1"    ;;
      *.tar)       tar xf "$1"    ;;
      *.tbz2)      tar xjf "$1"   ;;
      *.tgz)       tar xzf "$1"   ;;
      *.zip)       unzip "$1"     ;;
      *.Z)         uncompress "$1";;
      *.7z)        7z x "$1"      ;;
      *.deb)       ar x "$1"      ;;
      *.tar.xz)    tar xf "$1"    ;;
      *.tar.zst)   unzstd "$1"    ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# up N directories (default 1)
up () {
  local limit="${1:-1}"
  local d=""
  if [ "$limit" -le 0 ]; then limit=1; fi
  for ((i=1;i<=limit;i++)); do d="../$d"; done
  cd "$d" || echo "Couldn't go up $limit dirs."
}

# Yazi helper: yy opens yazi and returns to selected dir
yy() {
  local tmp
  tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
  yazi "$@" --cwd-file="$tmp"
  if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
    builtin cd -- "$cwd"
  fi
  rm -f -- "$tmp"
  printf '\e[?1000l\e[?1002l\e[?1003l\e[?1004l\e[?1006l'
}

# Zellij attach helper (manual use)
zz() {
  command -v zellij >/dev/null 2>&1 || { echo "zellij not found"; return 1; }
  zellij a dave1
  printf '\e[?1000l\e[?1002l\e[?1003l\e[?1004l\e[?1006l'
}
