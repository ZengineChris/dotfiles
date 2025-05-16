{
  description = "Multi-platform Dev Env (macOS + NixOS)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    home-manager.url = "github:nix-community/home-manager";

    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
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
      nixosHost = import ./hosts/thinkpad.nix;
    in
    {

      nixosConfigurations.${nixosHost.hostName} = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          pkgs = mkPkgs "x86_64-linux";
          inherit user nixosHost;
        };

        modules = [
          ./nixos/default.nix
          ./modules/devtools.nix
          ./modules/shell.nix

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.${user.name} = {
              imports = [ ./home/common.nix ];
              home.username = user.name;
              home.homeDirectory = user.homeDirectory;
            };
          }
        ];
      };
    };
}
