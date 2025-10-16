{ config, pkgs, ... }:

{
  home.packages = [
    # sway itself is cannot managed by Nix on Arch Linux
    pkgs.swaybg
    pkgs.waybar
    pkgs.rofi
    pkgs.kanshi
  ];
}
