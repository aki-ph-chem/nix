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

  # GitHub CLI
  programs.gh = {
    enable = true;
    settings = {
      version = 1;
      git_protocol = "https";
      prompt = "enabled";
      prefer_editor_prompt = "disabled";
      aliases = {
        co = "pr checkout";
      };
    };
    #oauth ??
    hosts = {
      "github.com" = {
        user = "aki-ph-chem";
      };
    };
    extensions = [ pkgs.gh-dash ];
  };
}
