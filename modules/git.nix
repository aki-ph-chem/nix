{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    settings = {
      user.name = "aki";
      user.email = "lmxox@proton.me";
      user.signingkey = "9EFC159FE516A29E3AAD1E32608634461D56BEA9";
      commit.gpgsign = true;
      extraConfig.init = {
        defaultBranch = "main";
      };
    };
  };
}
