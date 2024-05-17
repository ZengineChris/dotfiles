{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      v = "nvim";
      vim = "nvim";
      vi = "nvim";
      ll = "eza -lag";
      tree = "eza -T --icons";
      update = "sudo nixos-rebuild switch";
    };
    initExtra = ''
      export PATH="$HOME/go/bin:$PATH"

        bindkey -e
        bindkey '^j' history-search-forward
        bindkey '^k' history-search-backward


        HISTSIZE=5000
        HISTFILE=~/.zsh_history
        SAVEHIST=$HISTSIZE
        HISTDUP=erase

        setopt appendhistory
        setopt sharehistory
        setopt hist_ignore_space
        setopt hist_ignore_all_dups
        setopt hist_save_no_dups
        setopt hist_ignore_dups
        setopt hist_find_no_dups


        zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'


        eval "$(fzf --zsh)"

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
