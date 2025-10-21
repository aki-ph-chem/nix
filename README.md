# Nix

## update packeges

```bash
$ nix flake update # update flake
$ home-manager switch --flake . # in this repositroy
```

## Sway window manager

In the `sway` desktop environment, the following command installs packages related to `sway`.

```bash
$ HM_DESKTOP=sway home-manager switch --flake . --impure
```

## switch neovim version

```bash
$ NVIM_VERSION=0.11.3 home-manager switch --flake . --impure # use neovim 0.11.3
$ home-manager switch --flake . --impure # use neovim 0.11.4 as default
```

## serach packeges

```bash
$ nix search nixpkgs <packege name>
```
