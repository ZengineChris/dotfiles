{ config, pkgs, ... }: let
  configPath = "${config.home.homeDirectory}/github.com/zengineChris/dotfiles/home/aeroSpace/";
in
{
  xdg.configFile."aerospace".source = config.lib.file.mkOutOfStoreSymlink configPath;
}
