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

  home.packages = [
    pkgs.pinact
    # git related packages
    pkgs.lazygit
    #pkgs.gh
    pkgs.glab
  ];

  # GitHub CLI
  programs.gh = {
    enable = true;
    extensions = [ pkgs.gh-dash ];
  };
}
