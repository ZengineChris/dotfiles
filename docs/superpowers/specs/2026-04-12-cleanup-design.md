# Dotfiles Cleanup Design

**Date:** 2026-04-12

## Goal

Remove unused/orphaned configs, fix package tracking, add missing configs, and improve repo hygiene.

## Scope

### 1. Remove stow packages

Delete the following directories entirely — they reference tools that are not installed and have no entry in `packages.txt`:

- `kitty/` — user does not use kitty
- `jj/` — jujutsu is not installed
- `starship/` — starship is not installed

### 2. Fix `packages.txt`

| Action | Package |
|--------|---------|
| Remove | `kitty` — not used |
| Remove | `nushell` — not installed |
| Remove | `grimblast` — not installed |
| Fix name | `dms-shell-bin` → `dms-shell` (installed package name) |

### 3. Clean `hypr/.config/hypr/hyprland.conf`

Remove dead `windowrulev2` entries for terminals/apps that are not installed:

- `wezterm`
- `alacritty`
- `kitty`

### 4. Add `quickshell/` stow package

`quickshell` is installed and has a 427-line custom config at `~/.config/quickshell/shell.qml`. Add it to the repo:

```
quickshell/
└── .config/
    └── quickshell/
        └── shell.qml
```

### 5. Repo hygiene

- **Add `.gitignore`** with the following entries (both are local runtime data that should not be committed):
  ```
  .omc/
  .claude/
  ```
- **Delete `readme.md`** (31-line stub, redundant with `README.md`)
- **Update `README.md`**:
  - Update the `stow` command to include `quickshell`, remove `kitty`/`jj`/`starship`
  - Add a note clarifying that `wallpapers/` is not a stow package (just assets)

## Out of Scope

The following tools are installed but have no custom config in `~/.config/` — nothing to track:

- zoxide, direnv, yazi, dunst, wofi, dms, matugen, fastfetch

## Success Criteria

- No stow packages exist for uninstalled tools
- `packages.txt` reflects what is actually installed
- `hyprland.conf` has no windowrules for non-existent apps
- `quickshell/shell.qml` is tracked in the repo
- `.gitignore` prevents `.omc/` and `.claude/` from being committed
- Single canonical `README.md`
