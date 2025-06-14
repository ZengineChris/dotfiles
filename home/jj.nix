{
  config,
  pkgs,
  ...
}: let
  configPath = "${config.home.homeDirectory}/github.com/zengineChris/dotfiles/home/jj";
in {
  config = {
    home.packages = [
      pkgs.jujutsu
    ];
    xdg.configFile."jj".source = config.lib.file.mkOutOfStoreSymlink configPath;
  };
}
