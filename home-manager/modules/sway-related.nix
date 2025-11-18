{
  config,
  pkgs,
  dotfiles,
  ...
}:

{
  home.packages = [
    # sway itself is cannot managed by Nix on Arch Linux
    pkgs.swaybg
    pkgs.waybar
    pkgs.rofi
    pkgs.kanshi
  ];

  home.file = {
    # sway
    ".config/sway/config" = {
      source = "${dotfiles}/sway/config";
    };
    # waybar
    ".config/waybar" = {
      source = "${dotfiles}/sway/waybar";
      recursive = true;
    };
  };
}
