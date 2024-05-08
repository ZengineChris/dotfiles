{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      v = "nvim";
      ll = "eza -lag";
      tree = "eza -T --icons";
      update = "sudo nixos-rebuild switch";
    };
    initExtra = ''
        export PATH="$HOME/go/bin:$PATH"
    '';
    oh-my-zsh = {
      enable = true;
      theme = "";
      plugins = [
        "git"
        "npm"
        "history"
        "node"
        "golang"
        "rust"
        "deno"
      ];
    };
  };

}
