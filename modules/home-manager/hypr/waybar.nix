{ config, pkgs, lib, ... }:

{
    programs.waybar = {
        enable = true;
        settings = {
            mainbar = {
                layer = "top";
                position = "top";
                height = 32;
                modules-left = ["hyprland/workspaces"];
                modules-center = [];
                modules-right = ["temperature" "clock"];


                "hyprland/workspaces" = {
                    on-click = "activate";
                    format = "{icon}";
                    format-icons = {
                        "default" = "";
                        "1" = "1";
                        "2" = "2";
                        "3" = "3";
                        "4" = "4";
                        "5" = "5";
                        "6" = "6";
                        "7" = "7";
                        "8" = "8";
                        "9" = "9";
                        "active" = "󱓻";
                        "urgent" = "󱓻";
                    };
                };





            };
        };
        style = "
            @define-color rosewater #f5e0dc;
@define-color flamingo #f2cdcd;
@define-color pink #f5c2e7;
@define-color mauve #cba6f7;
@define-color red #f38ba8;
@define-color maroon #eba0ac;
@define-color peach #fab387;
@define-color yellow #f9e2af;
@define-color green #a6e3a1;
@define-color teal #94e2d5;
@define-color sky #89dceb;
@define-color sapphire #74c7ec;
@define-color blue #89b4fa;
@define-color lavender #b4befe;
@define-color text #cdd6f4;
@define-color subtext1 #bac2de;
@define-color subtext0 #a6adc8;
@define-color overlay2 #9399b2;
@define-color overlay1 #7f849c;
@define-color overlay0 #6c7086;
@define-color surface2 #585b70;
@define-color surface1 #45475a;
@define-color surface0 #313244;
@define-color base #1e1e2e;
@define-color mantle #181825;
@define-color crust #11111b;

        * {
             /* reference the color by using @color-name */
            color: @text;
          }
          window#waybar {
            /* you can also GTK3 CSS functions! */
            background-color: shade(@base, 0.9);
            border: 2px solid alpha(@crust, 0.3);
        }
        ";
    };
}