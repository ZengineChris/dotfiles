{
  config,
  pkgs,
  ...
}: let
  starshipPath = "${config.home.homeDirectory}/github.com/zengineChris/dotfiles/home/starship/starship.toml";
in {
  config = {
    home.packages = [
      # dependencies
      pkgs.starship
    ];
    xdg.configFile."starship.toml".source = config.lib.file.mkOutOfStoreSymlink starshipPath;
  };
}
