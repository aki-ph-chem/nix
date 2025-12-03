{
  config,
  pkgs,
  dotfiles,
  ...
}:
let
  swayConfigBase = builtins.readFile "${dotfiles}/sway/config";
in
{
  home.packages = [
    # sway itself is cannot managed by Nix on Arch Linux
    pkgs.swaybg
    pkgs.waybar
    pkgs.rofi
    pkgs.kanshi
    pkgs.waypaper
  ];

  home.file = {
    # sway
    ".config/sway/config" = {
      text = ''
        ${swayConfigBase}
        # ==========================================================
        # === START: Configuration Added/Merged by Home Manager  ===
        # ==========================================================

        # workspace 1 => fixed to eDP-1
        workspace 1 output eDP-1

        # swayfx specific
        corner_radius 10

        ## how to exit sway session
        #
        # $ swaymsg exit
        #
        # systemd
        exec_always "systemctl --user start sway-session.target"

        # for polkit
        exec /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1

        # ========================================================
        # === END: Configuration Added/Merged by Home Manager  ===
        # ========================================================
      '';
    };
    # waybar
    ".config/waybar" = {
      source = "${dotfiles}/sway/waybar";
      recursive = true;
    };
    # rofi
    ".config/rofi" = {
      source = "${dotfiles}/rofi";
      recursive = true;
    };
    # kanshi
    ".config/kanshi" = {
      source = "${dotfiles}/sway/kanshi";
      recursive = true;
    };
    # wlogout
    ".config/wlogout" = {
      source = "${dotfiles}/wlogout";
      recursive = true;
    };
  };
}
