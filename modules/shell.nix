{
  config,
  pkgs,
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
    '';

    ## alias
    shellAliases = {
      ls = "ls --color=auto";
      grep = "grep --colour=auto";
      egrep = "egrep --colour=auto";
      fgrep = "fgrep --colour=auto";

      lock = ''
        swaylock \
        	--screenshots \
        	--clock \
        	--indicator \
        	--indicator-radius 100 \
        	--indicator-thickness 7 \
        	--effect-blur 7x5 \
        	--effect-vignette 0.5:0.5 \
        	--ring-color bb00cc \
        	--key-hl-color 880033 \
        	--line-color 00000000 \
        	--inside-color 00000088 \
        	--separator-color 00000000 \
        	--grace 2 \
        	--fade-in 1'';
    };

  };

  home.sessionVariables.SHELL = "bash";
}
