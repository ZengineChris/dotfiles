{
  description = "Macbook Pro";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-24.05-darwin";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    templ.url = "github:a-h/templ";
    home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs-unstable";
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nix-darwin, nixpkgs, templ, home-manager, fenix, ... }@inputs:
    let
      configuration = { pkgs, ... }: {
        # List packages installed in system profile. To search by name, run:
        # $ nix-env -qaP | grep wget
        nixpkgs.config.allowUnfree = true;
        nixpkgs.overlays = [
          inputs.templ.overlays.default
          fenix.overlays.default
        ];
        environment.systemPackages =
          [
            pkgs.neovim
            pkgs.ffmpeg
            pkgs.ripgrep
            pkgs.obsidian
            pkgs.tailwindcss
            pkgs.pass
            pkgs.stylua
            pkgs.zoxide
            pkgs.iperf
            pkgs.wezterm
            pkgs.devenv

            ## Languages
            ## Golang
            pkgs.go
            pkgs.air
            pkgs.templ

            ## Js/Ts
            pkgs.nodejs
            pkgs.bun

            ## Rust
            (pkgs.fenix.complete.withComponents [
              "cargo"
              "clippy"
              "rust-src"
              "rustc"
              "rustfmt"
            ])
            pkgs.rust-analyzer-nightly

            pkgs.lua
            pkgs.llvm
            ## python
            pkgs.python3
            pkgs.poetry

            ## Lsp

            pkgs.golangci-lint
            pkgs.lua-language-server
            pkgs.tailwindcss-language-server
            pkgs.alejandra
            pkgs.nixd

            # infrastructur
            pkgs.qemu
            pkgs.helmfile
            # doppler
            pkgs.devpod
            pkgs.k3d
            pkgs.k9s
            pkgs.k6
            pkgs.trivy
            pkgs.kustomize
            pkgs.kubernetes-helm
            pkgs.kubectl
            pkgs.natscli
            pkgs.nats-server
            pkgs.timoni
            pkgs.cue
            pkgs.doctl

            ## Tools
            pkgs.jq
            pkgs.bat
            pkgs.bat-extras.prettybat
            pkgs.neofetch
            pkgs.yazi
            pkgs.fd
            pkgs.stow
          ];

        fonts.packages = [
          (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
        ];


        homebrew = {
          enable = true;
          brews = [
            {
              name = "sketchybar";
              start_service = true;
            }
            "huggingface-cli"
            "lima"
          ];
          taps = [
            "FelixKratz/formulae"
            "nikitabobko/tap"
          ];
          casks = [
            "google-chrome"
            "obs"
            "vlc"
            "nikitabobko/tap/aerospace"
          ];
          onActivation.cleanup = "zap";
        };


        system.defaults = {
          dock.autohide = true;
          dock.largesize = 64;
          dock.persistent-apps = [
            "${pkgs.wezterm}/Applications/Wezterm.app"
            "${pkgs.obsidian}/Applications/Obsidian.app"
            "/System/Applications/Mail.app"
            "/System/Applications/Calendar.app"
          ];
          finder.FXPreferredViewStyle = "clmv";
          loginwindow.GuestEnabled = false;
          NSGlobalDomain.AppleICUForce24HourTime = true;
          NSGlobalDomain.AppleInterfaceStyle = "Dark";
          NSGlobalDomain.KeyRepeat = 2;
        };

        users.users.christian = {
          name = "christian";
          home = "/Users/christian";
          shell = pkgs.nushell;
        };

        environment.shells = [ pkgs.nushell ];

        # Auto upgrade nix package and the daemon service.
        services.nix-daemon.enable = true;
        # nix.package = pkgs.nix;

        # Necessary for using flakes on this system.
        nix.settings.experimental-features = "nix-command flakes";

        # Create /etc/zshrc that loads the nix-darwin environment.
        #programs.zsh.enable = true; # default shell on catalina

        # Set Git commit hash for darwin-version.
        system.configurationRevision = self.rev or self.dirtyRev or null;

        # Used for backwards compatibility, please read the changelog before changing.
        # $ darwin-rebuild changelog
        system.stateVersion = 4;

        # The platform the configuration will be used on.
        nixpkgs.hostPlatform = "aarch64-darwin";
      };
    in
    {
      # Build darwin flake using:
      # $ darwin-rebuild build --flake .#simple
      darwinConfigurations."Zengine" = nix-darwin.lib.darwinSystem {
        modules = [
          configuration
          home-manager.darwinModules.home-manager
          {
            # `home-manager` config
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            #home-manager.backupFileExtension = true;
            home-manager.users.christian = import ./home.nix;
          }
        ];
      };

      # Expose the package set, including overlays, for convenience.
      darwinPackages = self.darwinConfigurations."Zengine".pkgs;
    };
}

