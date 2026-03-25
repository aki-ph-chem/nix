{ pkgs, ... }:
{
  programs.zellij = {
    enable = true;

    extraConfig = ''
      default_layout "compact"
    '';
  };
}
