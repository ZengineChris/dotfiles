{
  config,
  pkgs,
  ...
}: let
  configPath = "${config.home.homeDirectory}/github.com/zengineChris/dotfiles/home/ghostty/";
in {
  xdg.configFile."ghostty".source = config.lib.file.mkOutOfStoreSymlink configPath;
}
