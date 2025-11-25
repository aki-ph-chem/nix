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
        "${flakeRoot}/modules/neovide.nix"
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
