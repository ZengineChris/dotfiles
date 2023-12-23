source $HOME/.config/fish/conf.d/abbr.fish

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
# eval $HOME/opt/anaconda3/bin/conda "shell.fish" "hook" $argv | source
# <<< conda initialize <<<

export PATH="$HOME/bin:$PATH"
export PATH="/usr/local/anaconda3/bin:$PATH"
set -Ua fish_user_paths $HOME/.cargo/bin
starship init fish | source

source $HOME/.config/fish/themes/tokio_moon.fish

alias sail='[ -f sail ] && bash sail || bash vendor/bin/sail'
alias ls='eza -lag --header'
alias v='nvim'
set -gx VOLTA_HOME "$HOME/.volta"
set -gx PATH "$VOLTA_HOME/bin" $PATH

echo "Config file sourced successfully"


alias ls='eza -lag'
alias tree='eza -T --icons'

export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -l -g ""'
kubectl completion fish | source
