{ pkgs, ... }: {
  config = {
    home.packages = [
      # dependencies
      pkgs.gum
      # commit message helper
      (pkgs.writeShellScriptBin "gc"
        /*
          bash
        */
        ''
          TYPE=$(gum choose "fix" "feat" "docs" "style" "refactor" "test" "chore" "revert" "ci")
          BREAKING=$(gum choose "Breaking change" "Normal change")
          SCOPE=$(gum input --placeholder "scope")
          if  [[ "$BREAKING" == "Breaking change" ]]; then
              SUMMARY=$(gum input --value "$TYPE($SCOPE)!: " --placeholder "Summary of this change")
          else
              SUMMARY=$(gum input --value "$TYPE($SCOPE): " --placeholder "Summary of this change")
          fi

          DESCRIPTION=$(gum write --placeholder "Details of this change")

          if  [[ "$BREAKING" == "Breaking change" ]]; then
              DESCRIPTION="BREAKING CHANGE: $DESCRIPTION"
          fi
          # Commit these changes if user confirms
          gum confirm "Commit changes?" && git commit -m "$SUMMARY" -m "$DESCRIPTION"
        '')
    ];

    programs.git = {
      enable = true;
      lfs.enable = true;
      userName = "ZengineChris";
      userEmail = "zengineChris@gmail.com";
      delta = {
        enable = true;
        options = {
          diff-so-fancy = true;
          line-numbers = true;
          true-color = "always";
          # features => named groups of settings, used to keep related settings organized
          # features = "";
        };
      };
      extraConfig = {
        core.editor = "nvim";
        pull = {
          rebase = true;
        };
        init = {
          defaultBranch = "main";
        };
        commit.gpgsign = true;
        gpg.format = "ssh";
        user.signingkey = "~/.ssh/id_ed25519.pub";
      };
    };
  };
}
