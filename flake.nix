{
  description = "MacBook Dev Env for Apple Silicon";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    home-manager.url = "github:nix-community/home-manager";
    nix-darwin.url = "github:LnL7/nix-darwin";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    nixpkgs,
    home-manager,
    nix-darwin,
    ...
  }: {
    # Define darwin configuration for M1/M2 Mac
    darwinConfigurations."Zengine" = nix-darwin.lib.darwinSystem {
      system = "aarch64-darwin"; # Specifically for Apple Silicon
      specialArgs = {
        pkgs = import nixpkgs {
          system = "aarch64-darwin";
          config.allowUnfree = true;
          config.allowBroken = true;
        };
      };
      modules = [
        ./darwin/default.nix

        # Import modules with the Apple Silicon pkgs
        (import ./modules/devtools.nix {
          pkgs = import nixpkgs {
            system = "aarch64-darwin";
            config.allowUnfree = true;
          };
        })
        (import ./modules/deno.nix {
          pkgs = import nixpkgs {
            system = "aarch64-darwin";
            config.allowUnfree = true;
          };
        })
        (import ./darwin/homebrew.nix {inherit nixpkgs;})

        # Proper integration of home-manager with nix-darwin
        home-manager.darwinModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.backupFileExtension = "backup";
          home-manager.users.christian = {
            imports = [
              ./home/common.nix
              ./home/git.nix
              ./home/starship/default.nix
              ./home/nushell.nix
              ./home/nvim.nix
              ./home/sketchybar.nix
              ./home/ghostty.nix
              ./home/carapace.nix
              ./home/zellij.nix
            ];
          };
        }
      ];
    };

    # Standalone Home Manager configuration for M1/M2 Mac
    homeConfigurations."christian" = home-manager.lib.homeManagerConfiguration {
      pkgs = import nixpkgs {
        system = "aarch64-darwin";
        config.allowUnfree = true;
      };
      modules = [
        ./home/common.nix
      ];
      extraSpecialArgs = {
        # Add any special arguments you want to pass to your home modules
      };
      username = "christian";
      homeDirectory = "/Users/christian";
    };
  };
}
