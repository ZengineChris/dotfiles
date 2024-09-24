{ config, pkgs, ... }:

{
    enable = true;
    extraConfig = builtins.readFile ./config.lua;
}
