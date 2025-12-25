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

    # for secure-boot
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v1.0.0";
      # Optional but recommended to limit the size of your system closure.
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # GitHub: aki-ph-chem/dotfiles
    dotfiles = {
      url = "github:aki-ph-chem/dotfiles/main";
      flake = false;
    };

    # PGOPHER: aki-ph-chem/pgopher-nixos
    pgopher = {
      url = "github:aki-ph-chem/pgopher-nixos/main";
    };
  };

  outputs =
    {
      nixpkgs,
      lanzaboote,
      home-manager,
      nixgl,
      dotfiles,
      pgopher,
      self,
      ...
    }@inputs:
    {
      homeConfigurations = {
        # home-manager switch --flake .#archSway --impure
        archSway = import ./hosts/archSway {
          inherit inputs;
        };

        # home-manager switch --flake .#archXfce --impure
        archXfce = import ./hosts/archXfce {
          inherit inputs;
        };
      };

      nixosConfigurations = {
        # sudo nixos-rebuild switch --flake .#nixosSwayDesktop --impure
        nixosSwayDesktop = import ./hosts/nixosSwayDesktop {
          inherit inputs;
        };

        # sudo nixos-rebuild switch --flake .#nixosSwayLaptop --impure
        nixosSwayLaptop = import ./hosts/nixosSwayLaptop {
          inherit inputs;
        };
      };
    };
}
