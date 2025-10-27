# ❄️Nix ❄️

This repository contains my personal configuration files (Dotfiles) managed using **Nix** Flakes.

## 🚀 Key Features

The main features of this configuration are:

  - **Full Reproducibility**: The environment can be **reliably reproduced** using `flake.lock`.
  - **Declarative Configuration**: **Home Manager** is used to centrally manage **home directory** configurations across various operating systems (macOS, Linux, etc.).
  - **Modularity**: The configuration is split into **Nix modules** based on functionality, improving maintainability and reusability.
  - **Diverse Environment Support**:
      - **CLI** tools
      - Development environments like **Neovim**
      - Desktop environments including **Sway**
      - Support for **GUI applications** using **NixGL** (for non-NixOS environments)

## 🛠️ Configuration Management

### 📥 Applying the Configuration

The basic commands to apply this configuration. Execute these in the root directory of the repository.

| Environment      | Command                                                  | Notes                                                                 |
|:-----------------|:---------------------------------------------------------|:----------------------------------------------------------------------|
| **Standard**     | `home-manager switch --flake .`                          | Applies CLI tools and general settings.                               |
| **Sway Desktop** | `HM_DESKTOP=sway home-manager switch --flake . --impure` | Applies **Sway** and related packages (sets an environment variable). |

### 🔄 Updating Packages

Update the inputs (e.g., **Nixpkgs** and other Flakes) and reapply the configuration.

```bash
$ nix flake update            # Updates Flake dependencies (e.g., nixpkgs, home-manager) and rewrites flake.lock
$ home-manager switch --flake . # Applies the updated configuration
```

### 🌳 Directory Structure 🌳

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
