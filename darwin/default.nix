{pkgs, ...}: {
  users.users.christian = {
    name = "christian";
    home = "/Users/christian";
    shell = pkgs.nushell;
  };

  environment.shells = [pkgs.nushell];
  # System-wide environment variables
  environment.variables = {
    XDG_CONFIG_HOME = "/Users/christian/.config";
  };

  # You can also set these in home-manager's sessionVariables if you prefer
  # If you need these to be set in home-manager:
  home-manager.users.christian = {
    home.sessionVariables = {
      XDG_CONFIG_HOME = "/Users/christian/.config";
    };
  };

  # Basic nix-darwin system configuration
  nix.settings.experimental-features = ["nix-command" "flakes"];

  fonts.packages = [
    pkgs.nerd-fonts._0xproto
    pkgs.nerd-fonts.droid-sans-mono
    pkgs.nerd-fonts.jetbrains-mono
  ];

  # System defaults
  system.defaults = {
    NSGlobalDomain = {
      AppleShowAllExtensions = true;
      InitialKeyRepeat = 15;
      KeyRepeat = 2;
      AppleInterfaceStyle = "Dark";
    };
    dock = {
      autohide = true;
      show-recents = false;
    };
    finder = {
      AppleShowAllExtensions = true;
      QuitMenuItem = true;
    };
  };

  # Add any other darwin-specific configuration here
  system.stateVersion = 4;

  # Temp fix
  ids.gids.nixbld = 350;
}
