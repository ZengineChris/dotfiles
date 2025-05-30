{ pkgs, ... }: {
  config = {
    programs = {
      # zoxide is a smarter cd command, inspired by z and autojump.
      # It remembers which directories you use most frequently,
      # so you can "jump" to them in just a few keystrokes.
      # zoxide works on all major shells.
      #
      #   z foo              # cd into highest ranked directory matching foo
      #   z foo bar          # cd into highest ranked directory matching foo and bar
      #   z foo /            # cd into a subdirectory starting with foo
      #
      #   z ~/foo            # z also works like a regular cd command
      #   z foo/             # cd into relative path
      #   z ..               # cd one level up
      #   z -                # cd into previous directory
      #
      #   zi foo             # cd with interactive selection (using fzf)
      #
      #   z foo<SPACE><TAB>  # show interactive completions (zoxide v0.8.0+, bash 4.4+/fish/zsh only)
      zoxide = {
        enable = true;
        enableBashIntegration = true;
        enableZshIntegration = true;
        enableNushellIntegration = true;
      };

      # Atuin replaces your existing shell history with a SQLite database,
      # and records additional context for your commands.
      # Additionally, it provides optional and fully encrypted
      # synchronisation of your history between machines, via an Atuin server.
      atuin = {
        enable = true;
        enableBashIntegration = true;
        enableZshIntegration = true;
        enableNushellIntegration = true;
      };

      fzf = {
        enable = true;
        # https://github.com/catppuccin/fzf
        # catppuccin-mocha
        colors = {
          "bg+" = "#313244";
          "bg" = "#1e1e2e";
          "spinner" = "#f5e0dc";
          "hl" = "#f38ba8";
          "fg" = "#cdd6f4";
          "header" = "#f38ba8";
          "info" = "#cba6f7";
          "pointer" = "#f5e0dc";
          "marker" = "#f5e0dc";
          "fg+" = "#cdd6f4";
          "prompt" = "#cba6f7";
          "hl+" = "#f38ba8";
        };
      };
    };
  };
}
