{
  description = "Home Manager configuration of aki";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # The hash value in the URL ‘github:NixOS/nixpkgs/<hash value>’ was obtained
    # by searching for neovim on https://www.nixhub.io, then selecting version 0.11.3.
    nixpkgs-nvim0113 = {
      url = "github:NixOS/nixpkgs/648f70160c03151bc2121d179291337ad6bc564b";
    };
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      nixpkgs-nvim0113,
      ...
    }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      homeConfigurations."aki" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        extraSpecialArgs = {
          inherit nixpkgs-nvim0113;
        };

        modules = [ ./home-manager/home.nix ];
      };
    };
}
