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
        ../../home-manager/modules/neovim.nix
        ../../home-manager/modules/cli-tools.nix
        ../../home-manager/modules/git.nix
        ../../home-manager/modules/neovide.nix
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
