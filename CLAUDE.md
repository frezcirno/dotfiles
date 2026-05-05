# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repo is

A personal dotfiles repository managed by a single bash script, [dotfile](dotfile). There is no build system, package manager, or test suite — the repo is a copy of selected configuration files plus the script that moves them in and out of their real locations on the system.

## Path mapping (core convention)

Files are stored under two top-level prefixes that mirror real filesystem locations:

- `home/<rel>` ↔ `$HOME/<rel>` (e.g. [home/.vimrc](home/.vimrc) ↔ `~/.vimrc`)
- `rootfs/<rel>` ↔ `/<rel>` (e.g. [rootfs/etc/hosts](rootfs/etc/hosts) ↔ `/etc/hosts`)

Anything outside `home/` or `rootfs/` (such as the [dotfile](dotfile) script itself) is repo-only and `install` will skip it. The `path2repo`/`repo2path` functions in [dotfile](dotfile) implement this mapping.

Files are stored as regular **copies**, not symlinks. Editing a file in the repo does not affect the live system until `install` runs, and vice versa. Only the executable bit of file mode is preserved (git limitation).

## Commands

The `./dotfile` script takes a subcommand and a path. Paths can be either real paths or in-repo paths — the script normalizes via `realpath`.

```
./dotfile list <path>          # show whether path(s) are tracked and where they map to
./dotfile track <path>         # copy real file -> repo (skips if already tracked)
./dotfile untrack <path>       # remove file from repo
./dotfile retrack <path>       # untrack + track (force-refresh repo copy from live file)
./dotfile retrack_all          # refresh every tracked file from live system
./dotfile install <path>       # copy repo file -> real location (overwrites)
./dotfile install_all          # install every tracked file
```

`track` is **idempotent / non-destructive**: it refuses to overwrite an existing repo copy. Use `retrack` to pull updates from a live file into the repo.

`install` and `retrack` are **destructive** at their respective destinations (`rm -f` then `cp`). `install_all` will overwrite live system files including those under `rootfs/` (root-owned `/etc`, `/usr/lib/systemd/...`).

## Typical workflows

- Add a new config to tracking: edit it in place, then `./dotfile track ~/.config/foo/bar`, then commit.
- Pull live changes back into the repo before committing: `./dotfile retrack ~/.config/foo/bar` (or `retrack_all`).
- Apply repo state to a fresh machine: clone, then `./dotfile install_all` (likely needs sudo for `rootfs/` paths).

## Things to know when editing

- The script uses `set -e` and assumes GNU coreutils (`realpath`, `stat -c`, GNU `sed`); it is Linux-only.
- `track`/`untrack`/`list` walk directories with `find ... -type f -and -not -path './.git/*'`. Symlinks are not followed and not tracked.
- `_install_file` calls `chown` to match repo ownership — for `rootfs/` files this requires running as root.
- The repo is large (~1700 tracked files) and spans application configs (i3, polybar, rofi, fcitx, atuin, htop, gdb/gef, vim, tmux, bash, git, gradle, maven, pip, conda, aria2, GTK) plus a few system-level files under `rootfs/etc` and `rootfs/usr/lib/systemd/system`.
