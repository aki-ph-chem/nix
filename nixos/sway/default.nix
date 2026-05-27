{
  pkgs,
  userName,
  wlroots-nvidia,
}:
let
  swayfx-nvidia = pkgs.symlinkJoin {
    name = "swayfx-nvidia";
    paths = [ pkgs.swayfx ];

    nativeBuildInputs = [ pkgs.makeWrapper ];

    postBuild = ''
      wrapProgram $out/bin/sway \
      --prefix LD_LIBRARY_PATH: "${pkgs.lib.makeLibraryPath [ wlroots-nvidia ]}"
    '';
  };
in
{
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    xwayland.enable = true;
    # sway related pkgs
    extraPackages = [
      pkgs.waybar
      pkgs.swaybg
      pkgs.swayidle
      pkgs.rofi
      pkgs.brightnessctl
      pkgs.clipman
      pkgs.grim
      pkgs.foot
    ];
    #use swayfx
    package = swayfx-nvidia;
  };

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
