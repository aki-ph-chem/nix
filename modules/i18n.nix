{ config, pkgs, ... }:
{
  i18n = {
    inputMethod = {
      enable = true;
      # daemon of fcitx5 is luanched
      # by graphical-session.target (by systemd)
      type = "fcitx5";
      fcitx5 = {
        addons = [
          pkgs.qt6Packages.fcitx5-configtool
          pkgs.fcitx5-mozc
          pkgs.libsForQt5.fcitx5-qt
          pkgs.fcitx5-gtk
        ];
      };
    };
  };
}
