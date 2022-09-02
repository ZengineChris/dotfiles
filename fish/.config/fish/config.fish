source $HOME/.config/fish/conf.d/abbr.fish

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
# eval $HOME/opt/anaconda3/bin/conda "shell.fish" "hook" $argv | source
# <<< conda initialize <<<

export PATH="$HOME/bin:$PATH"
export PATH="/usr/local/anaconda3/bin:$PATH"
set -Ua fish_user_paths $HOME/.cargo/bin
starship init fish | source

alias sail='[ -f sail ] && bash sail || bash vendor/bin/sail'
alias ls='exa -lag --header'
alias vim='nvim'
  # TokyoNight Color Palette
    set -l foreground c0caf5
    set -l selection 364A82
    set -l comment 565f89
    set -l red f7768e
    set -l orange ff9e64
    set -l yellow e0af68
    set -l green 9ece6a
    set -l purple 9d7cd8
    set -l cyan 7dcfff
    set -l pink bb9af7
    
    # Syntax Highlighting Colors
    set -g fish_color_normal $foreground
    set -g fish_color_command $cyan
    set -g fish_color_keyword $pink
    set -g fish_color_quote $yellow
    set -g fish_color_redirection $foreground
    set -g fish_color_end $orange
    set -g fish_color_error $red
    set -g fish_color_param $purple
    set -g fish_color_comment $comment
    set -g fish_color_selection --background=$selection
    set -g fish_color_search_match --background=$selection
    set -g fish_color_operator $green
    set -g fish_color_escape $pink
    set -g fish_color_autosuggestion $comment
    
    # Completion Pager Colors
    set -g fish_pager_color_progress $comment
    set -g fish_pager_color_prefix $cyan
    set -g fish_pager_color_completion $foreground
    set -g fish_pager_color_description $comment
