{
  description = "Nix config";

  inputs = {

    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };


  outputs = { nixpkgs, home-manager, ... }: {
    homeConfigurations = {
      "christian" = home-manager.lib.homeManagerConfiguration {
        # darwin is the macOS kernel and aarch64 means ARM, i.e. apple silicon
        pkgs = nixpkgs.legacyPackages.aarch64-darwin;
        modules = [ ./home.nix ];
      };
    };
  };


}
