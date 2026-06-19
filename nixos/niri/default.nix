{ pkgs, ... }:
{
  imports = [ ./options.nix ];

  programs.niri = {
    enable = true;
    # niri related pkgs
    extraPackages = [
      pkgs.waybar
      pkgs.swaybg
      pkgs.swayidle
      pkgs.rofi
      pkgs.brightnessctl
      pkgs.clipman
      pkgs.grim
      pkgs.foot
    ];
    # enable Xwayland
    xwayland.enable = true;
  };
}
