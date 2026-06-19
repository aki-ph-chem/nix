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

  services.libinput.enable = true;

  users.users."${userName}".packages = with pkgs; [
    ## sway-related
    swaylock-effects
    wlogout
    waypaper
    flameshot
    libinput-gestures
  ];
}
