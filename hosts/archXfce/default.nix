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
        (import "${flakeRoot}/modules/shell.nix" { inherit pkgs shellConfigs; })
        "${flakeRoot}/modules/wezterm.nix"
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
