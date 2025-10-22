{ config, pkgs, ... }:

{

  home.packages = [
    # CLI tools
    pkgs.hugo
    pkgs.fzf
    pkgs.fd
    pkgs.ripgrep
    pkgs.bat
    # git related packages
    pkgs.lazygit
    pkgs.gh
    pkgs.glab
    # languages tool
    pkgs.uv
    pkgs.deno
    pkgs.shellcheck
    ## lux: package manager for Lua
    pkgs.lux-cli
    ## GNU global
    pkgs.global
    ## for network
    pkgs.ookla-speedtest
    pkgs.netcat-gnu
  ];

  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    nix-direnv.enable = true;
  };
}
