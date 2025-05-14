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
      pkgs.just

      pkgs.jq
      pkgs.bat
      pkgs.bat-extras.prettybat
      pkgs.bat-extras.batgrep
      pkgs.bat-extras.batdiff
      pkgs.neofetch
      pkgs.yazi
      pkgs.fd
      pkgs.delta # A viewer for git and diff output
      pkgs.jujutsu

      pkgs.hyperfine # command-line benchmarking tool
      pkgs.gping # ping, but with a graph(TUI)
      pkgs.doggo # DNS client for humans

      # Interactively filter its input using fuzzy searching, not limit to filenames.
      pkgs.fzf
      # search for files by name, faster than find
      pkgs.fd

      pkgs.sad # CLI search and replace, just like sed, but with diff preview.

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
