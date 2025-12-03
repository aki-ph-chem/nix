{ pkgs, userName }:
{
  users.users."${userName}".packages = with pkgs; [
    xfce.thunar
    xfce.ristretto
    qpdfview
    zathura
    firefox
    chromium
    wezterm
    vlc
  ];
}
