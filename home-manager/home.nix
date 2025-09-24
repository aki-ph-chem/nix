{ config, pkgs, ... }:

{
  home.username = "aki";
  home.homeDirectory = "/home/aki";
  home.stateVersion = "25.05";

  imports = [
  ];

  home.packages = [
    pkgs.cowsay
    # sway itself is cannot managed by Nix on Arch Linux
    pkgs.swaybg
    pkgs.waybar
    pkgs.rofi
    pkgs.kanshi
    # CLI tools
    pkgs.hugo
    pkgs.fzf
    pkgs.lazygit
    pkgs.uv
    # for Neovim
    pkgs.deno
    pkgs.gopls
    pkgs.lua-language-server
    ### Language server for Nix Language
    pkgs.nil
    ## in previously installed by Cargo
    ### Language server for Tex(LaTex)
    pkgs.texlab
    ### fomatter for Lua
    pkgs.stylua
    ### formatter for json
    pkgs.jq
    ### Language server for Markdown
    pkgs.markdown-oxide
    ### lux: package manager for Lua
    pkgs.lux-cli
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/aki/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
