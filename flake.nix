{
  description = "MacBook Dev Env for Apple Silicon";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { self
    , nixpkgs
    , nix-darwin
    , home-manager
    , ...
    }:
    let
      mkPkgs = system:
        import nixpkgs {
          inherit system;
          config.allowUnfree = true;
          config.allowBroken = true;
        };
      user = import ./users/christian.nix;
      darwinHost = import ./hosts/zengine.nix;
      nixosHost = import ./hosts/zenbook.nix;
    in
    {
      darwinConfigurations.${darwinHost.hostName} = nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        specialArgs = {
          pkgs = mkPkgs "aarch64-darwin";
          inherit user darwinHost;
        };
        modules = [
          ./darwin/default.nix
          ./modules/devtools.nix
          (import ./darwin/homebrew.nix { inherit nixpkgs; })

          home-manager.darwinModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "backup";
            home-manager.users.${user.name} = {
              home.username = user.name;
              home.homeDirectory = user.homeDirectory;
              home.stateVersion = "25.05";
              imports = [
                ./home/git.nix
                ./home/starship/default.nix
                ./home/nushell.nix
                ./home/nvim.nix
                ./home/sketchybar.nix
                ./home/ghostty.nix
                ./home/carapace.nix
                ./home/zellij.nix
                ./home/tools.nix
                ./home/aeroSpace.nix
                ./home/jj.nix
              ];
            };
          }
        ];
      };

      nixosConfigurations.${nixosHost.hostName} = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          pkgs = mkPkgs "x86_64-linux";
          inherit user nixosHost;
        };

        modules = [
          ./nixos/default.nix
          ./modules/devtools.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.${user.name} = {
              home.stateVersion = "25.05";
              imports = [
                ./home/git.nix
                ./home/starship/default.nix
                ./home/nushell.nix
                ./home/nvim.nix
                ./home/sketchybar.nix
                ./home/ghostty.nix
                ./home/carapace.nix
                ./home/zellij.nix
                ./home/tools.nix
              ];
              home.username = user.name;
              home.homeDirectory = user.homeDirectory;
            };
          }
        ];
      };
    };
}
