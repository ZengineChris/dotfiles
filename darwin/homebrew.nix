{...}: {
  homebrew = {
    enable = true;
    brews = [
      {
        name = "sketchybar";
        start_service = true;
      }
      "huggingface-cli"
      "lima"
      "colima"
      "gh"
      "gnupg"
      "posting"
    ];
    taps = [
      "FelixKratz/formulae"
      "nikitabobko/tap"
      "homebrew/services"
    ];
    casks = [
      "google-chrome"
      "obs"
      "vlc"
      "ghostty"
      "nikitabobko/tap/aerospace"
    ];
    onActivation.cleanup = "zap";
    onActivation.upgrade = true;
  };
}
