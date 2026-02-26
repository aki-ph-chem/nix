{
  pkgs,
  pgopher,
  userName,
}:
{
  users.users."${userName}".packages = with pkgs; [
    # filer
    thunar
    # image viwer
    ristretto
    tumbler # This is required for thumbnail display in 'thunar' and 'ristretto'.

    # movie & music
    vlc

    # pdf viwer
    qpdfview
    zathura

    # neovim GUI
    neovide
    # tarminal emulator
    wezterm

    # web browser
    chromium
    firefox
    # e-mail & feed
    thunderbird

    # pgopher
    pgopher.packages.x86_64-linux.default
  ];
}
