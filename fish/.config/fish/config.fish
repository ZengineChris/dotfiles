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
set -l foreground DCD7BA
set -l selection 2D4F67
set -l comment 727169
set -l red C34043
set -l orange FF9E64
set -l yellow C0A36E
set -l green 76946A
set -l purple 957FB8
set -l cyan 7AA89F
set -l pink D27E99

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
