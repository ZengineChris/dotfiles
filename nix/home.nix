{ config, pkgs, ... }:

{
  home.username = "christian";
  home.homeDirectory = "/Users/christian";


  home.packages = with pkgs; [
    deno
    hugo
    btop

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
    lua
    llvm
    python3
    ocaml

  ];


  programs.git = {
    enable = true;
    userName = "ZengineChris";
    userEmail = "zengineChris@gmail.com";
  };


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
