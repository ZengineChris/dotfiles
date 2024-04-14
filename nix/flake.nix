{
  description = "Nix config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    unstable.url = "nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, unstable, ... }: {

    homeConfigurations = {
      "zengine.chris" = inputs.home-manager.lib.homeManagerConfiguration {
        system = "aarch_64-darwin";
        homeDirectory = "/Users/christian";
        username = "zengine.chris";
        configuration.imports = [ ./home.nix ];
      };
    };

    packages."aarch64-darwin".default =
      let
        pkgs = nixpkgs.legacyPackages."aarch64-darwin";
        unstablePkgs = unstable.legacyPackages."aarch64-darwin";
      in
      pkgs.buildEnv {
        name = "dev-env";
        paths = with pkgs; [
          # general tools
          git
          tmux
          wget
          curl
          jq
          bat
          fzf
          eza
          gnupg
          ripgrep
          neofetch
          fd
          uutils-coreutils
          stow
          # ... add your tools here


          # Dev tools 
          #devenv.packages.aarch64-darwin.devenv
          neovim
          starship
          kitty
          zsh
          oh-my-zsh
          zsh-syntax-highlighting
          zsh-completions
          go-task
          golangci-lint

          # infrastructur
          podman
          k3d
          k9s
          trivy
          kustomize
          kubernetes-helm
          kubectl
          natscli
          nats-server


          # languages 
          go
          nodejs
          deno
          lua
          llvm
          python3

        ];
      };
  };

}
