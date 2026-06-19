{ pkgs, userName }:
{
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
