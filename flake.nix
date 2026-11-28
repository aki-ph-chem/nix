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

    # gtk2 is being removed from nixpkgs (NixOS/nixpkgs#410814), but PGOPHER's
    # prebuilt binary still requires it. Pin the last release branch that
    # still ships gtk2. See docs/gtk2-pgopher.md for details.
    nixpkgs-gtk2.url = "github:nixos/nixpkgs/nixos-26.05";

    # for secure-boot
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v1.1.0";
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
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # containerd-shim-wasmtime-v1
    containerd-shim-wasmtime-v1 = {
      url = "github:aki-ph-chem/runwasi-flake/feat/containerd-shim-wasmtime-v1";
    };

    # Declarative Agent Skills management (Home Manager module)
    agent-skills = {
      url = "github:Kyure-A/agent-skills-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Agent Skills catalogs (the upstream repositories have no flake.nix)
    mattpocock-skills = {
      url = "github:mattpocock/skills";
      flake = false;
    };
    yomiyasu-skills = {
      url = "github:nanaism/yomiyasu";
      flake = false;
    };
    ponytail-skills = {
      url = "github:DietrichGebert/ponytail";
      flake = false;
    };
  };

  outputs =
    {
      nixpkgs,
      lanzaboote,
      home-manager,
      nixgl,
      nixpkgs-gtk2,
      dotfiles,
      pgopher,
      containerd-shim-wasmtime-v1,
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
