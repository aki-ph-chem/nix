{
  pkgs,
  shellConfigs,
  ...
}:
{
  # see: https://home-manager-options.extranix.com/?query=programs.bash&release=master
  programs.bash = {
    enable = true;
    enableCompletion = true;

    initExtra = ''
      # config for git prompt
      source "${pkgs.git}/share/git/contrib/completion/git-prompt.sh"
      PS1='\[\e[1;36m\]\[\e[m\] \[\e[1;34m\]\t\[\e[m\] \[\e[1;36m\]🐗\[\e[m\] \[\e[1;36m\] \W\[\e[m\] \[\e[1;31m\]$(__git_ps1 "(%s)")\[\e[m\] \n \$ '

      # set vi mode & ecs->jj
      set -o vi
      bind '"jj":vi-movement-mode'

      # fuzzy finder
      eval "$(fzf --bash)"

      # added from shell.nix
      ${shellConfigs.envVarShell}
    '';

    ## alias
    shellAliases = {
      ls = "ls --color=auto";
      grep = "grep --colour=auto";
      egrep = "egrep --colour=auto";
      fgrep = "fgrep --colour=auto";

    }
    // shellConfigs.aliases;

  };

  home.sessionVariables.SHELL = "bash";
}
