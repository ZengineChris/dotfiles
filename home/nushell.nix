{ config, pkgs, ... }: let
  configPath = "${config.home.homeDirectory}/github.com/zengineChris/dotfiles/home/nushell/";
in
{
  xdg.configFile."nushell".source = config.lib.file.mkOutOfStoreSymlink configPath;
}
