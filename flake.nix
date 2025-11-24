{
  description = "Home Manager configuration of aki";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixgl.url = "github:nix-community/nixGL";
    # GitHub: aki-ph-chem/dotfiles
    dotfiles = {
      url = "github:aki-ph-chem/dotfiles/main";
      flake = false;
    };
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      nixgl,
      dotfiles,
      ...
    }:
    let
      stdenv.hostPlatform.system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${stdenv.hostPlatform.system};
      overlays = [
        nixgl.overlay
      ];
    in
    {
      homeConfigurations = {
        aki = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;

          # Specify your home configuration modules here, for example,
          # the path to your home.nix.
          modules = [
            ./home-manager/home.nix
            { nixpkgs.overlays = overlays; }
          ];

          extraSpecialArgs = {
            inherit dotfiles;
          };

          # Optionally use extraSpecialArgs
          # to pass through arguments to home.nix
        };
      };
    };
}
