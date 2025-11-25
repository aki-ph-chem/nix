{ pkgs, userName }:
{
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };

  users.users."${userName}".packages = with pkgs; [
    ## sway-related
    swayidle
    swaybg
    swaylock-effects
    xwayland
    pkgs.waybar
    pkgs.rofi
    ## other
    brightnessctl
    clipman
  ];
}
