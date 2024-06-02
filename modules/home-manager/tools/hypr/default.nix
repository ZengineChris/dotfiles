{ config, pkgs, ... }:


{
      home.packages = with pkgs; [
        hyprpager
        hypridle
        hyprlock
      ];

}
