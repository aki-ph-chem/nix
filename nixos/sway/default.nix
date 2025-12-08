{ pkgs, userName }:
{
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    xwayland.enable = true;
    # sway related pkgs
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
    #use swayfx
    package = pkgs.swayfx;
  };

  # ref: https://wiki.nixos.org/wiki/Sway
  systemd.user.services.kanshi = {
    description = "kanshi daemon";
    environment = {
      WAYLAND_DISPLAY = "wayland-1";
      DISPLAY = ":0";
    };

    serviceConfig = {
      Type = "simple";
      ExecStart = ''${pkgs.kanshi}/bin/kanshi'';
    };
  };

  users.users."${userName}".packages = with pkgs; [
    ## sway-related
    swaylock-effects
    wlogout
    waypaper
  ];
}
