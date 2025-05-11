{ config, pkgs, ... }: let
  configPath = "${config.home.homeDirectory}/github.com/zengineChris/dotfiles/home/sketchybar/";
in
{
  xdg.configFile."sketchybar".source = config.lib.file.mkOutOfStoreSymlink configPath;
}
