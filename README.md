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
