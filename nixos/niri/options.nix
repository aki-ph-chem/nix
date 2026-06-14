{ config, lib, pkgs, ... }:
let
  cfg = config.programs.niri;
in
{
  options.programs.niri.extraPackages = lib.mkOption {
    type = with lib.types; listOf package;
    default = [ ];
    description = "Extra packages for niri";
  };

  options.programs.niri.xwayland.enable = lib.mkEnableOption "XWayland support for niri";

  config = lib.mkIf cfg.enable {
    environment.systemPackages = cfg.extraPackages
      ++ lib.optionals cfg.xwayland.enable [ pkgs.xwayland ];
  };
}
