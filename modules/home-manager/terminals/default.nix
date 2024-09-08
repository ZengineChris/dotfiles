{ config, pkgs, ... }:

{
    imports = [
        #./alacritty/default.nix
        #./kitty/default.nix
        ./wezterm/default.nix
    ];
}
