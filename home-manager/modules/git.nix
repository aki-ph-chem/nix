{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    settings = {
      user.name = "aki";
      user.email = "aki@mymail.com";
      extraConfig.init = {
        defaultBranch = "main";
      };
    };
  };
}
