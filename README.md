# Dave Terminal Standard

Cross-platform terminal setup (Debian + Windows).

## Install on Debian

```bash
git clone <your-repo-url> ~/dotfiles
cd ~/dotfiles
./bootstrap/bootstrap-debian.sh
```

## Bash-First Setup

- Bash is the default shell layer in this repo.
- `~/.bashrc` is linked to `config/bash/bashrc.shim`.
- The shim sources:
  - repo-managed settings from `config/bash/bashrc`
  - user-specific overrides from `~/.bashrc.local` (if present)

## Preserve Existing `~/.bashrc`

- Preferred: move your current `~/.bashrc` to `~/.bashrc.local` before linking.
- Safe fallback: if you run `./scripts/link.sh` first, the script backs up existing `~/.bashrc` to a timestamped file like `~/.bashrc.bak.YYYYMMDDHHMMSS`.
- After linking, you can restore personal settings by copying content from that backup into `~/.bashrc.local`.
- `~/.bashrc.local` is your personal layer and is intended to hold machine/user-specific customizations.

## Shell Notes

- `rm` uses `trash-put` when `trash-cli` is installed.
- `rmp` is the permanent delete alias (`rm -i` via the real `rm` command).
- `ls`/`ll` use `lla` if `lla` is installed.
- If login hangs, Starship preexec hooks are disabled for compatibility.
- If you see ++ lines, xtrace was on; DTS disables xtrace + Starship preexec for compatibility.

## Doctor

```bash
cd ~/dotfiles
./scripts/doctor.sh
```
