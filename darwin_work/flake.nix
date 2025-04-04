{
  description = "Cognigy MacBook";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-24.11-darwin";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    templ.url = "github:a-h/templ";
    home-manager.url = "github:nix-community/home-manager/release-24.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs-unstable";
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nix-darwin,
    nixpkgs,
    templ,
    home-manager,
    fenix,
    ...
  } @ inputs: let
    configuration = {pkgs, ...}: {
      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      nixpkgs.config.allowUnfree = true;
      nixpkgs.overlays = [
        inputs.templ.overlays.default
      ];
      environment.systemPackages = [
        pkgs.neovim
        pkgs.ffmpeg
        pkgs.ripgrep
        fenix.packages."aarch64-darwin".minimal.toolchain # rust

        pkgs.obsidian
        pkgs.tailwindcss
        pkgs.pass
        pkgs.stylua
        pkgs.zoxide
        pkgs.iperf
        pkgs.air
        pkgs.templ
        pkgs.wezterm

        ## Languages
        pkgs.go
        pkgs.nodejs
        pkgs.lua
        pkgs.llvm
        pkgs.python3
        pkgs.ocaml
        pkgs.deno
        pkgs.zig
        pkgs.bun

        pkgs.libyaml
        pkgs.libsass
        pkgs.libffi
        pkgs.autoconf
        pkgs.automake
        pkgs.pkg-config
        pkgs.openssl
        pkgs.unused
        pkgs.universal-ctags

        ## Lsp

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
        pkgs.eza
        pkgs.stow
        pkgs.coreutils
        pkgs.curl
        pkgs.asdf-vm
      ];

      fonts.packages = [
        (pkgs.nerdfonts.override {fonts = ["JetBrainsMono"];})
      ];

      homebrew = {
        enable = true;
        taps = [
          "FelixKratz/formulae"
          "nikitabobko/tap"
        ];
        brews = [
          "libyaml"
          "coreutils"
          "curl"
          "stow"
          "gnu-tar"
          "libpq"
          "lima"
          "kubelogin"
          {
            name = "sketchybar";
            start_service = true;
          }
          "huggingface-cli"
        ];
        casks = [
          "gpg-suite"
          "discord"
          "obs"
          "nikitabobko/tap/aerospace"
          "spotify"
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

      users.users.cbartelt = {
        name = "cbartelt";
        home = "/Users/cbartelt";
      };

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
  in {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#simple
    darwinConfigurations."Cognigy" = nix-darwin.lib.darwinSystem {
      modules = [
        configuration
        home-manager.darwinModules.home-manager
        {
          # `home-manager` config
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          #home-manager.backupFileExtension = true;
          home-manager.users.cbartelt = import ./home.nix;
        }
      ];
    };

    # Expose the package set, including overlays, for convenience.
    darwinPackages = self.darwinConfigurations."Cognigy".pkgs;
  };
}
