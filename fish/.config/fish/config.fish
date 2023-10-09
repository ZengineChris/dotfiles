source $HOME/.config/fish/conf.d/abbr.fish

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
# eval $HOME/opt/anaconda3/bin/conda "shell.fish" "hook" $argv | source
# <<< conda initialize <<<

export PATH="$HOME/bin:$PATH"
export PATH="/usr/local/anaconda3/bin:$PATH"
set -Ua fish_user_paths $HOME/.cargo/bin
starship init fish | source


set -gx  XDG_CONFIG_HOME "$HOME/k9s"

source $HOME/.config/fish/themes/tokio_moon.fish

alias sail='[ -f sail ] && bash sail || bash vendor/bin/sail'
alias ls='exa -lag --header'
alias vim='nvim'
set -gx VOLTA_HOME "$HOME/.volta"
set -gx PATH "$VOLTA_HOME/bin" $PATH

thefuck --alias | source
