{
  description = "Macbook Pro";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    templ.url = "github:a-h/templ";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs-unstable";
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    devx = {
      url = "github:zenginechris/devx";
      inputs.nixpkgs.follows = "nixpkgs"; # Add this line
    };
  };

  outputs = {
    self,
    nix-darwin,
    nixpkgs-unstable,
    # Add this
    nixpkgs,
    templ,
    home-manager,
    fenix,
    devx,
    ...
  } @ inputs: let
    configuration = {pkgs, ...}: {
      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      nixpkgs.config.allowUnfree = true;
      nixpkgs.config.allowBroken = true;
      nixpkgs.overlays = [
        inputs.templ.overlays.default
        fenix.overlays.default
        # Add devx overlay
        (final: prev: {
          devx-cli = devx.packages.${prev.system}.default;
        })
      ];
      environment.systemPackages = [
        pkgs.uutils-coreutils
        pkgs.neovim
        pkgs.ffmpeg
        pkgs.ripgrep
        pkgs.obsidian
        pkgs.tailwindcss
        pkgs.pass
        pkgs.stylua
        pkgs.zoxide
        pkgs.iperf
        pkgs.direnv
        pkgs.curlie
        pkgs.lazygit

        ##
        pkgs.devx-cli

        ## Languages
        ## Golang
        pkgs.go
        pkgs.air
        pkgs.templ
        pkgs.go-task

        ## Js/Ts
        pkgs.nodejs
        pkgs.bun
        pkgs.pnpm

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
        pkgs.uv

        ## Erlang
        pkgs.erlang
        pkgs.gleam

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
        pkgs.docker
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
        pkgs.kcl

        ## Tools
        pkgs.jq
        pkgs.bat
        pkgs.bat-extras.prettybat
        pkgs.bat-extras.batgrep
        pkgs.bat-extras.batdiff
        pkgs.neofetch
        pkgs.yazi
        pkgs.fd
        pkgs.stow
        pkgs.delta
        pkgs.jujutsu
      ];

      fonts.packages = [
        pkgs.nerd-fonts._0xproto
        pkgs.nerd-fonts.droid-sans-mono
        pkgs.nerd-fonts.jetbrains-mono
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
          "colima"
          "gh"
          "gnupg"
          "posting"
        ];
        taps = [
          "FelixKratz/formulae"
          "nikitabobko/tap"
          "homebrew/services"
        ];
        casks = [
          "google-chrome"
          "obs"
          "vlc"
          "ghostty"
          "nikitabobko/tap/aerospace"
        ];
        onActivation.cleanup = "zap";
        onActivation.upgrade = true;
      };

      system.defaults = {
        dock.autohide = true;
        dock.largesize = 64;
        dock.persistent-apps = [
     #     "${pkgs.ghostty}/Applications/Ghostty.app"
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

      environment.shells = [pkgs.nushell];

      # nix.package = pkgs.nix;

      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";

      # Create /etc/zshrc that loads the nix-darwin environment.
      #programs.zsh.enable = true; # default shell on catalina

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;
      # Auto upgrade nix package and the daemon service.
      ids.gids.nixbld = 350;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 4;

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";
    };
  in {
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
