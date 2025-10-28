# ❄️Nix ❄️

This repository contains my personal configuration files (Dotfiles) managed using **Nix** Flakes.

## 🚀 Key Features

The main features of this configuration are:

  - **Full Reproducibility**: The environment can be **reliably reproduced** using `flake.lock`.
  - **Declarative Configuration**: **Home Manager** is used to centrally manage **home directory** configurations   
  - **Modularity**: The configuration is split into **Nix modules** based on functionality, improving maintainability and reusability.
  - **Diverse Environment Support**:
      - **CLI** tools
      - Development environments like **Neovim**
      - Support for **GUI applications** using **NixGL** (for non-NixOS environments)

## 🛠️ Configuration Management

### 📥 Applying the Configuration

The basic commands to apply this configuration. Execute these in the root directory of the repository.

| Environment      | Command                                                  | Notes                                                                                  |
|:-----------------|:---------------------------------------------------------|:---------------------------------------------------------------------------------------|
| **Standard**     | `home-manager switch --flake .`                          | Applies CLI tools and general settings.                                                |
| **Sway Desktop** | `HM_DESKTOP=sway home-manager switch --flake . --impure` | Applies **Sway** related packages and gui app packages (sets an environment variable). |

### 🔄 Updating Packages

Update the inputs (e.g., **Nixpkgs** and other Flakes) and reapply the configuration.

```bash
$ nix flake update            # Updates Flake dependencies (e.g., nixpkgs, home-manager) and rewrites flake.lock
$ home-manager switch --flake . # Applies the updated configuration (Standard)
```

### 🌳 Directory Structure 🌳

The configuration files are organized as follows:

| File/path                               | Description                                                                                            |
|-----------------------------------------|--------------------------------------------------------------------------------------------------------|
| `flake.nix`                             | The Entry point and declaration of my configuration. The Home Manager instance is also declared here.  |
| `flake.lock`                            | The lock file that  guarantees the **reproducibility** of the Flake.                                   |
| `home-manager/home.nix`                 | The **main Home Manager configuration file**                                                           |
| `home-manager/modules/`                 | Directory for **Nix modules** split by functionality.                                                  |
| `home-manager/modules/cli-tools.nix`    | Configuration and installation for **CLI applications**                                                |
| `home-manager/modules/git.nix`          | **Git** configuration.                                                                                 |
| `home-manager/modules/gui-app.nix`      | Installation of **GUI applications**. Includes settings for using **NixGL** in non-NixOS environments. |
| `home-manager/modules/i18n.nix`         | Configuration related to **Internationalization** (I18n) and **IME** (e.g., `fcitx5`).                 |
| `home-manager/modules/neovim.nix`       | **Neovim** configuration, including LSP,formatter, ..etc (**NOT** include plugins).                    |
| `home-manager/modules/sway-related.nix` | Configuration for the **Sway** window manager related packages (e.g., `waybar`, `rofi`).               |

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

or search package name in https://search.nixos.org/packages.
