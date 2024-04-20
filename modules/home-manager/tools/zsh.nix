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
