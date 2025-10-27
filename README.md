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

## 🧹 Maintenance Commands

### 🗑️ Cleaning Up Old Generations

Removes files from `/nix/store` that are no longer referenced by **old generations** (previous states of the system or home environment), freeing up disk space.

```bash
$ nix-collect-garbage --delete-old
```

### 🔍 Package Search

Search for available packages within the Nixpkgs repository.

```bash
$ nix search nixpkgs <package name>
```
