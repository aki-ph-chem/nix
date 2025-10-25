# Nix

## 🌳 Directory Structure 🌳

The configuration files are organized as follows:

| File/path                               | Description                                     |
|-----------------------------------------|-------------------------------------------------|
| `flake.nix`                             | entry point and declaration of my configuration |
| `flake.lock`                            | lock file that ensures reproducibility          |
| `home-manager/home.nix`                 | actual configuration for my home directory      |
| `home-manager/modules/cli-tools.nix`    | config for CLI apps                             |
| `home-manager/modules/git.nix`          | config for git                                  |
| `home-manager/modules/gui-app.nix`      | gui applications supported by NixGL             |
| `home-manager/modules/i18n.nix`         | config for IME (fcitx5)                         |
| `home-manager/modules/neovim.nix`       | config for Neovim                               |
| `home-manager/modules/sway-related.nix` | sway-related packeges                           |


## update packeges

```bash
$ nix flake update # update flake
$ home-manager switch --flake . # in this repositroy
```

In the `sway` desktop environment, the following command installs packages related to `sway`.

```bash
$ HM_DESKTOP=sway home-manager switch --flake . --impure
```

## serach packeges

```bash
$ nix search nixpkgs <packege name>
```

## remove old files (old generations) in `/nix/store`

```bash
$ nix-collect-garbage --delete-old
```
