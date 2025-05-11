{ pkgs }: {
  config = {
    environment.systemPackages = [
      pkgs.uutils-coreutils
      pkgs.neovim
      pkgs.ffmpeg
      pkgs.ripgrep
      pkgs.obsidian
      pkgs.pass
      pkgs.zoxide
      pkgs.iperf
      pkgs.direnv
      pkgs.curlie
      pkgs.lazygit

      pkgs.jq
      pkgs.bat
      pkgs.bat-extras.prettybat
      pkgs.bat-extras.batgrep
      pkgs.bat-extras.batdiff
      pkgs.neofetch
      pkgs.yazi
      pkgs.fd
      pkgs.delta
      pkgs.jujutsu
      #pkgs.ghostty

      # DevOps
      pkgs.qemu
      pkgs.helmfile
      pkgs.k3d
      pkgs.k9s
      pkgs.k6
      pkgs.trivy
      pkgs.kustomize
      pkgs.kubernetes-helm
      pkgs.kubectl
      pkgs.doctl

      # LSP's and linter to edit the dotfiles
      pkgs.alejandra
      pkgs.nixd
      pkgs.lua-language-server
    ];
  };
}
