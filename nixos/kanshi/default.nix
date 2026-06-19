{ pkgs, ... }: {
  # ref: https://wiki.nixos.org/wiki/Sway
  systemd.user.services.kanshi = {
    description = "kanshi daemon";
    environment = {
      WAYLAND_DISPLAY = "wayland-1";
      DISPLAY = ":0";
    };

    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.kanshi}/bin/kanshi";
    };
  };
}
