{
  description = "Home Manager configuration of aki";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
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
      pkgs-nvim0113 = import nixpkgs-nvim0113 { inherit system; };
    in
    {
      homeConfigurations."aki" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [ ./home-manager/home.nix ];

        # Optionally use extraSpecialArgs
        # to pass through arguments to home.nix
      };
    };
}
