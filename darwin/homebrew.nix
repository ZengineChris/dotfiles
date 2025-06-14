{...}: {
  homebrew = {
    global = {
      autoUpdate = true;
    };
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
      #"opencode"
      "telepresenceio/telepresence/telepresence-oss"
    ];
    taps = [
      "FelixKratz/formulae"
      "nikitabobko/tap"
      #      "opencode-ai/tap/opencode"
      "homebrew/services"
    ];
    casks = [
      "google-chrome"
      "obs"
      "vlc"
      "ghostty"
      "nikitabobko/tap/aerospace"
    ];
    onActivation.cleanup = "uninstall";
    onActivation.upgrade = true;
  };
}
