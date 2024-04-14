{
  description = "Nix config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    darwin.url = "github:lnl7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };


  outputs = inputs@{ nixpkgs, home-manager, darwin, ... }: {
    darwinConfigurations = {
      hostname = darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [
          # ./configuration.nix
          home-manager.darwinModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.christian = import ./home.nix;

            # Optionally, use home-manager.extraSpecialArgs to pass
            # arguments to home.nix
          }
        ];
      };
    };



    packages."aarch64-darwin".default = pkgs: {
      # Define your default set of packages for the aarch64-darwin system here
      neovim = pkgs.neovim;
      tmux = pkgs.tmux;
      # Add more packages as needed
    };
  };



}
