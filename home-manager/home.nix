{ config, pkgs, ... }:

{
  home.username = "aki";
  home.homeDirectory = "/home/aki";
  home.stateVersion = "25.05";

  imports = [
    ./modules/git.nix
    ./modules/neovim.nix
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
  ];

  i18n = {
    inputMethod = {
      enable = true;
      type = "fcitx5";
      fcitx5 = {
        addons = [
          pkgs.fcitx5-configtool
          pkgs.fcitx5-mozc
          pkgs.libsForQt5.fcitx5-qt
          pkgs.fcitx5-gtk
        ];
      };
    };
  };

  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    nix-direnv.enable = true;
  };

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
