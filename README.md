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

| machine name         | Notes                                                                                  |
|:---------------------|:---------------------------------------------------------------------------------------|
| **archXfce**         | Applies CLI tools and general settings.                                                |
| **archSway**         | Applies **Sway** related packages and gui app packages (sets an environment variable). |
| **nixosSwayDesktop** | config for NixOS + Sway                                                                |

- for Arch Linux + sway

```bash
home-manager switch --flake .#archSway --impure
```

- for Arch Linux + Xfce 

```bash
home-manager switch --flake .#archXfce --impure
```

- for NixOS + sway

```bash
sudo nixos-rebuild switch --flake .#nixosSwayDesktop --impure
```

### 🔄 Updating Packages

Update the inputs (e.g., **Nixpkgs** and other Flakes) and reapply the configuration.

```bash
nix flake update            # Updates Flake dependencies (e.g., nixpkgs, home-manager) and rewrites flake.lock
home-manager switch --flake .#<machine name> --impure # Applies the updated configuration (Standard)
```

### 🌳 Directory Structure 🌳

The configuration files are organized as follows(Folded):

<details>
<summary>here</summary>

| File/path                   | Description                                                                                                      |
|-----------------------------|------------------------------------------------------------------------------------------------------------------|
| `flake.nix`                 | The Entry point and declaration of my configuration. The Home Manager instance is also declared here.            |
| `flake.lock`                | The lock file that  guarantees the **reproducibility** of the Flake.                                             |
| `hosts/archSway`            | config for Arch Linux + Sway                                                                                     |
| `hosts/archXfce`            | config for Arch Linux + Xfce                                                                                     |
| `modules/`                  | Directory for **Nix modules** split by functionality.                                                            |
| `modules/cli-tools.nix`     | Configuration and installation for **CLI applications**                                                          |
| `modules/git.nix`           | **Git** configuration.                                                                                           |
| `modules/gui-app-nixgl.nix` | Installation of **GUI applications**. Includes settings for using **NixGL** in non-NixOS environments.           |
| `modules/i18n.nix`          | Configuration related to **Internationalization** (I18n) and **IME** (e.g., `fcitx5`).                           |
| `modules/neovim.nix`        | **Neovim** configuration, including LSP,formatter, ..etc (**NOT** include plugins).                              |
| `modules/neovide-nixgl.nix` | **Neovide**(extra GUI for neovim) configuration Includes settings for using **NixGL** in non-NixOS environments. |
| `modules/sway-related.nix`  | Configuration for the **Sway** window manager related packages (e.g., `waybar`, `rofi`).                         |

</details>

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
