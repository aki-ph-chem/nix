{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "aki";
    userEmail = "aki@mymail.com";
    extraConfig.init = {
      defaultBranch = "main";
    };
  };
}
