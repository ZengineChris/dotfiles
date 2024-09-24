{ config, pkgs, ... }:

{
    enable = true;
    settings = pkgs.lib.importTOML ./starship.toml;
}
