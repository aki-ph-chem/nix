{
  inputs,
}:
let
  userName = "aki";
  inherit (inputs)
    home-manager
    nixgl
    nixpkgs
    dotfiles
    config
    self
    ;
  stdenv.hostPlatform.system = "x86_64-linux";
  pkgs = nixpkgs.legacyPackages.${stdenv.hostPlatform.system};
  overlays = [
    nixgl.overlay
  ];
  # flakeRoot is path which flake.nix exists
  flakeRoot = self.outPath;
  shellConfigs = {
    envVarShell = ''
      # Rust
      export PATH="$HOME/.cargo/bin:$PATH"
      . "$HOME/.cargo/env"

      # Haskell
      [ -f "$HOME/.ghcup/env" ] && . "$HOME/.ghcup/env" # ghcup-env
    '';
    aliases = {
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
in
home-manager.lib.homeManagerConfiguration {
  inherit pkgs;

  modules = [
    {
      home.username = "${userName}";
      home.homeDirectory = "/home/${userName}";
      home.stateVersion = "25.05";

      imports = [
        "${flakeRoot}/modules/neovim.nix"
        "${flakeRoot}/modules/cli-tools.nix"
        "${flakeRoot}/modules/git.nix"
        "${flakeRoot}/modules/neovide-nixgl.nix"
        "${flakeRoot}/modules/i18n.nix"
        "${flakeRoot}/modules/sway-related.nix"
        "${flakeRoot}/modules/gui-app-nixgl.nix"
        "${flakeRoot}/modules/nerd-fonts.nix"
        (import "${flakeRoot}/modules/shell.nix" { inherit pkgs shellConfigs; })
        "${flakeRoot}/modules/wezterm.nix"
        "${flakeRoot}/modules/gpg-agent.nix"
      ];

      home.packages = [
      ];

      home.file = { };

      home.sessionVariables = {
        # EDITOR = "emacs";
      };

      programs.home-manager.enable = true;
    }

    { nixpkgs.overlays = overlays; }
  ];

  extraSpecialArgs = {
    inherit dotfiles;
  };
}
