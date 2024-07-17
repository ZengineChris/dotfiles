{ config, pkgs, ... }:

{
  home.packages = [
    # dependencies 
    pkgs.gum

    # commit message helper
    # I have to start with this name to prevent a collission with the oh my zsh 
    # git plugin
    (pkgs.writeShellScriptBin "ggc" /*bash*/ ''
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
}

