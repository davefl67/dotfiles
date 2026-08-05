# Dave Terminal Standard

Cross-platform terminal setup (Debian + Windows).

## Install on Debian

```bash
git clone https://github.com/davefl67/dotfiles.git ~/.local/src/dotfiles
cd ~/.local/src/dotfiles
./bootstrap/bootstrap-debian.sh
```

## Bash-First Setup

- Bash is the default shell layer in this repo.
- `~/.bashrc` is linked to `config/bash/.bashrc`.
- `~/.bashrc.d` is linked to the repo's modular `config/bash/.bashrc.d/` directory.
- `~/.zshenv` and `~/.zshrc` are linked to the repo's Zsh configuration.
- Machine-specific settings belong in the ignored `config/bash/.bashrc.d/99-local.sh`.

## Preserve Existing `~/.bashrc`

- `./scripts/link.sh` backs up an existing target to a timestamped file like `~/.bashrc.bak.YYYYMMDDHHMMSS` before linking it.
- Review any backup before deciding whether its contents belong in a tracked module or the ignored `99-local.sh`.
- Never commit secrets, tokens, private keys, or machine-specific credentials.

## Shell Notes

- `rm` uses `trash-put` when `trash-cli` is installed.
- `rmp` is the permanent delete alias (`rm -i` via the real `rm` command).
- `ls`/`ll` use `lla` if `lla` is installed.
- If login hangs, Starship preexec hooks are disabled for compatibility.
- If you see ++ lines, xtrace was on; DTS disables xtrace + Starship preexec for compatibility.
- tmux is installed and configured, but never auto-started; launch it manually when wanted.

## Doctor

```bash
cd ~/.local/src/dotfiles
./scripts/doctor.sh
```

The doctor checks the installed tool baseline and confirms that the shell and
selected config files resolve into this repository.

## Updating and backing up

```bash
cd ~/.local/src/dotfiles
git pull --ff-only
git status --short
./scripts/link.sh
./scripts/doctor.sh
git add -A
git commit -m "Update terminal configuration"
git push origin main
```
