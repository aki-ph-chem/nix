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
    ;
  stdenv.hostPlatform.system = "x86_64-linux";
  pkgs = nixpkgs.legacyPackages.${stdenv.hostPlatform.system};
  overlays = [
    nixgl.overlay
  ];
in
home-manager.lib.homeManagerConfiguration {
  inherit pkgs;

  modules = [
    {
      home.username = "${userName}";
      home.homeDirectory = "/home/${userName}";
      home.stateVersion = "25.05";

      imports = [
        ../../modules/neovim.nix
        ../../modules/cli-tools.nix
        ../../modules/git.nix
        ../../modules/neovide.nix
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
