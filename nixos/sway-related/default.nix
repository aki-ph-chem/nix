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
  systemd = {
    # disabled waybar.services
    user.services.waybar.wantedBy = pkgs.lib.mkForce [ ];

    # waybar for niri
    user.services.waybar-niri = {
      # [Unit]
      description = "Highly customizable Wayland bar for Sway and Wlroots based compositors";
      documentation = "https://github.com/Alexays/Waybar/wiki/";
      partOf = "graphical-session.target";
      after = "graphical-session.target";
      requisite = "graphical-session.target";

      #[Services]
      # wip
      ## ToDo: how to get $HOME

      #[Install]
      wantedBy = [ "niri-session.target" ];
    };
  };
}
