# Dave Terminal Standard

Cross-platform terminal setup (Debian + Windows).

## Install on Debian

```bash
git clone <your-repo-url> ~/dotfiles
cd ~/dotfiles
./bootstrap/bootstrap-debian.sh
```

## Shell Notes

- `rm` uses `trash-put` when `trash-cli` is installed.
- `rmp` is the permanent delete alias (`rm -i` via the real `rm` command).
- `ls`/`ll` use `lla` if `lla` is installed.
- Interactive `zsh` shells auto-attach to tmux session `main` (or create it if missing).
- Bypass auto-tmux with `DISABLE_TMUX=1 zsh`.
- Start a plain shell (no auto-tmux, no rc files) with `DISABLE_TMUX=1 zsh -f`.

## Doctor

```bash
cd ~/dotfiles
./scripts/doctor.sh
```
