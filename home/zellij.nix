{
  config,
  pkgs,
  ...
}: let
  configPath = "${config.home.homeDirectory}/github.com/zengineChris/dotfiles/home/zellij";
in {
  config = {
    home.packages = [
      # dependencies
      pkgs.zellij
    ];
    xdg.configFile."zellij".source = config.lib.file.mkOutOfStoreSymlink configPath;
  };
}
