{ config, pkgs, ... }:
{
  i18n = {
    inputMethod = {
      enable = true;
      type = "fcitx5";
      fcitx5 = {
        addons = [
          pkgs.fcitx5-configtool
          pkgs.fcitx5-mozc
          pkgs.libsForQt5.fcitx5-qt
          pkgs.fcitx5-gtk
        ];
      };
    };
  };
}
