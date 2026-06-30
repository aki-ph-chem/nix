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

  # define niri-session
  systemd.user.targets.niri-session = {
    description = "niri compositor session";
    documentation = [ "man:systemd.special(7)" ];
    bindsTo = [ "graphical-session.target" ];
    wants = [ "graphical-session-pre.target" ];
    after = [ "graphical-session-pre.target" ];
  };
}
