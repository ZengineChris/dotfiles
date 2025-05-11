{ config, pkgs, ... }: let
  configPath = "${config.home.homeDirectory}/github.com/zengineChris/dotfiles/home/nvim/";
in
{
  xdg.configFile."nvim".source = config.lib.file.mkOutOfStoreSymlink configPath;
}
