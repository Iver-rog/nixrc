{
  description = "Nixos config flake";

  inputs = {
    # nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    solaar = {
      # url = "https://flakehub.com/f/Svenum/Solaar-Flake/*.tar.gz"; # For latest stable version
      #url = "https://flakehub.com/f/Svenum/Solaar-Flake/0.1.1.tar.gz"; # uncomment line for solaar version 1.1.13
      url = "github:Svenum/Solaar-Flake/main"; # Uncomment line for latest unstable version
      inputs.nixpkgs.follows = "nixpkgs";
    }; 
  };

  outputs = { self, nixpkgs, nixos-wsl, solaar, ... }@inputs:
    let
      user = "iver";
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
    # NixOS configuration
    nixosConfigurations.razer = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs user;};
      modules = [
        ./hosts/nixos/configuration.nix
        inputs.home-manager.nixosModules.default
        solaar.nixosModules.default
      ];
    };
    
    # WSL configuration
    nixosConfigurations.wsl = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs user;};
      modules = [
        nixos-wsl.nixosModules.wsl
        ./hosts/wsl/configuration.nix
        inputs.home-manager.nixosModules.default
      ];
    };
  };
}
