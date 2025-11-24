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
      self,
      ...
    }@inputs:
    {
      homeConfigurations = {
        # home-manager switch --flake .#archSway --impure
        archSway = import ./hosts/archSway {
          inherit inputs;
        };
      };
    };
}
