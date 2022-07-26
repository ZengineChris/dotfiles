source $HOME/.config/fish/conf.d/abbr.fish

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
eval /Users/christian/opt/anaconda3/bin/conda "shell.fish" "hook" $argv | source
# <<< conda initialize <<<

export PATH="$HOME/bin:$PATH"
export PATH="/usr/local/anaconda3/bin:$PATH"

starship init fish | source

alias sail='[ -f sail ] && bash sail || bash vendor/bin/sail'