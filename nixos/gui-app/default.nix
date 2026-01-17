{
  pkgs,
  pgopher,
  userName,
}:
{
  users.users."${userName}".packages = with pkgs; [
    thunar
    tumbler # This is required for thumbnail display in 'thunar' and 'ristretto'.
    ristretto
    qpdfview
    zathura
    firefox
    thunderbird
    neovide
    chromium
    wezterm
    vlc
    pgopher.packages.x86_64-linux.default
  ];
}
