{ config, pkgs, ... }:

{
  home = {
    username = "cbartelt";
    homeDirectory = "/Users/cbartelt";
    packages = with pkgs; [
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
      btop
      # ... add your tools here
      asdf-vm
      openssl
      libyaml

      # Applications
      rectangle
      stats

      # Dev tools 
      #devenv.packages.aarch64-darwin.devenv
      neovim
      starship
      kitty
      wezterm
      yazi
      zoxide
      zsh
      oh-my-zsh
      zsh-syntax-highlighting
      zsh-completions
      go-task
      golangci-lint
      hugo
      lazysql

      # infrastructur
      qemu
      docker
      podman
      doppler
      k3d
      k9s
      trivy
      kustomize
      kubernetes-helm
      kubectl
      natscli
      nats-server
      timoni
      cue
      doctl
      azure-cli


      # languages 
      go
      nodejs
      lua
      llvm
      python3
      ocaml
      deno
      zig
      gleam
      rustup

    ];
  };

 # xdg.configFile."nvim".source = ./../../nvim/.config/nvim;

  imports = [
    ./../../modules/home-manager/tools/git.nix
    ./../../modules/home-manager/tools/zsh.nix
    ./../../modules/home-manager/tools/tmux/default.nix
    ./../../modules/home-manager/tools/starship/default.nix
    ./../../modules/home-manager/terminals/default.nix
  ];

  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "23.11";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
