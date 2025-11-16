{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    settings = {
      user.name = "aki";
      user.email = "aki@mymail.com";
      user.signingkey = "9EFC159FE516A29E3AAD1E32608634461D56BEA9";
      extraConfig.init = {
        defaultBranch = "main";
      };
    };
  };
}
