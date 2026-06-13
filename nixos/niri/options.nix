{ config, lib, ... }:
let
  cfg = config.programs.niri;
in
{
  options.programs.niri.extraPackages = lib.mkOption {
    type = with lib.types; listOf package;
    default = [ ];
    description = "Extra packages for niri";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = cfg.extraPackages;
  };
}
