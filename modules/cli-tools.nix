{ config, pkgs, ... }:

{

  home.packages = [
    # CLI tools
    pkgs.fzf
    pkgs.fd
    pkgs.ripgrep
    pkgs.bat
    pkgs.yazi
    pkgs.lazydocker
    # languages tool
    pkgs.shellcheck
    ## lux: package manager for Lua
    pkgs.lux-cli
    ## GNU global
    ## for network
    pkgs.netcat-gnu
    ## TUI feed reader
    pkgs.bulletty
  ];

  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    nix-direnv.enable = true;
  };
}
