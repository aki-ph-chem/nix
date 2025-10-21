{
  config,
  pkgs,
  ...
}:

let
  desktopEnv = builtins.getEnv "HM_DESKTOP";
  tracedDesktopEnv = builtins.trace ("DEBUG: HM_DESKTOP is: " + desktopEnv) desktopEnv;
  isSway = tracedDesktopEnv == "sway";
  tracedIsSway = builtins.trace (
    "DEBUG: isSway flag is:  " + (if isSway then "true" else "false")
  ) isSway;
in

{
  home.username = "aki";
  home.homeDirectory = "/home/aki";
  home.stateVersion = "25.05";

  imports = [
    ./modules/neovim.nix
    ./modules/cli-tools.nix
    ./modules/git.nix
  ]
  ++ (
    if tracedIsSway then
      [
        ./modules/i18n.nix
        ./modules/sway-related.nix
      ]
    else
      [ ]
  );

  home.packages = [
  ];

  home.file = {
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
