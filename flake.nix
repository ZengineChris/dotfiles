{
  description = "Home Manager";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    darwin.url = "github:lnl7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };


  outputs = { nixpkgs, home-manager, ... }: {
    homeConfigurations = {

    "christian" = home-manager.lib.homeManagerConfiguration {
        # darwin is the macOS kernel and aarch64 means ARM, i.e. apple silicon
        pkgs = nixpkgs.legacyPackages.aarch64-darwin;
        modules = [ ./hosts/default/home.nix ];
      };
      "chris" = home-manager.lib.homeManagerConfiguration {
        # darwin is the macOS kernel and aarch64 means ARM, i.e. apple silicon
	pkgs = nixpkgs.legacyPackages.x86_64-linux;
        modules = [ ./hosts/nix/home.nix ];
      };
    };
  };

}
