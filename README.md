# Nix

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
