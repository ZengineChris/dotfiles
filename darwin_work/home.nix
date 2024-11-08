{
  config,
  pkgs,
  ...
}: let
  inherit (config.lib.file) mkOutOfStoreSymlink;
in {
  programs.home-manager.enable = true;

  home.username = "cbartelt";
  home.homeDirectory = "/Users/cbartelt";
  xdg.enable = true;

  #xdg.configFile.nvim.source = mkOutOfStoreSymlink "/github.com/zengineChris/dotfiles/nvim/.config/nivm";

  home.stateVersion = "23.11";

  programs = {
    tmux = import ../home/tmux.nix {inherit pkgs;};
    wezterm = import ../home/wezterm/default.nix {inherit config pkgs;};
    starship = import ../home/starship/default.nix {inherit config pkgs;};
    git = import ../home/git.nix {inherit config pkgs;};
    #zsh = import ../home/zsh.nix {inherit config pkgs;};
    fzf = import ../home/fzf.nix {inherit config pkgs;};
    nushell = (import ../home/nushell/default.nix { inherit config pkgs; });
    carapace = (import ../home/carapace.nix { inherit config pkgs; });
  };

  imports = [
    ../home/scripts/git.nix
  ];
}
