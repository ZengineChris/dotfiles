#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Blesh must be sourced first, before any other tool that touches readline/completion
[[ -f /usr/share/blesh/ble.sh ]] && source /usr/share/blesh/ble.sh --noattach

# ============================================================================
# Environment Variables
# ============================================================================

export EDITOR="nvim"
export VISUAL="nvim"

export PATH="$HOME/.local/bin:$HOME/.cargo/bin:$PATH"

# Carapace bridges configuration
export CARAPACE_BRIDGES='zsh,fish,bash,inshellisense'

# ============================================================================
# Shell Options
# ============================================================================

shopt -s histappend        # Append to history file, don't overwrite
shopt -s checkwinsize      # Check window size after each command
shopt -s cmdhist           # Save multi-line commands in one history entry
shopt -s globstar 2>/dev/null  # Enable ** for recursive globbing (bash 4+)

# ============================================================================
# Aliases
# ============================================================================

alias ls='eza -l -m -a --no-permissions'
alias grep='grep --color=auto'
alias v='nvim'
alias npm="node $HOME/.npm-global-lib/bin/npm-cli.js"
alias npx="node $HOME/.npm-global-lib/bin/npx-cli.js"

# ============================================================================
# Functions
# ============================================================================

parse_git_branch() {
    git rev-parse --abbrev-ref HEAD 2>/dev/null
}

set_prompt() {
    local last_status=$?

    local dir="${PWD/#$HOME/\~}"

    local path_segment="\[\033[34m\]${dir}\[\033[0m\]"

    local git_branch
    git_branch=$(parse_git_branch)
    local git_segment=""
    if [ -n "$git_branch" ]; then
        git_segment=" on \[\033[33m\]${git_branch}\[\033[0m\]"
    fi

    # Show [nix] when inside nix-shell/nix develop, [direnv] when direnv is active
    local nix_segment=""
    if [[ ${IN_NIX_SHELL-} == "pure" || ${IN_NIX_SHELL-} == "impure" ]]; then
        nix_segment=" \[\033[36m\][nix]\[\033[0m\]"
    elif [ -n "${DIRENV_DIR-}" ]; then
        nix_segment=" \[\033[36m\][direnv]\[\033[0m\]"
    fi

    local k8s_segment=""
    if [ -n "${KUBECONFIG-}" ] && command -v kubectl &>/dev/null; then
        local k8s_ctx
        k8s_ctx=$(kubectl config current-context 2>/dev/null)
        if [ -n "$k8s_ctx" ]; then
            k8s_segment=" \[\033[35m\][k8s:${k8s_ctx}]\[\033[0m\]"
        fi
    fi

    local status=""
    if [ $last_status -ne 0 ]; then
        status="\[\033[31m\]✗\[\033[0m\] "
    else
        status="\[\033[32m\]✓\[\033[0m\] "
    fi

    PS1="${status}${path_segment}${git_segment}${nix_segment}${k8s_segment}\n❯ "
}

# Session manager with sesh and fzf
sss() {
    if ! command -v sesh &>/dev/null; then
        echo "Error: sesh is not installed" >&2
        return 1
    fi
    if ! command -v fzf &>/dev/null; then
        echo "Error: fzf is not installed" >&2
        return 1
    fi
    local session
    session=$(sesh list | fzf --height 40% --reverse --border)
    if [ -n "$session" ]; then
        sesh connect "$session"
    fi
}

# Kubeconfig selection
kselect() {
    local SEARCH_PATHS=("$HOME/.kube/configs" "$HOME/.kube/clusters")
    local SELECTED_CONFIG
    SELECTED_CONFIG=$(find "${SEARCH_PATHS[@]}" -type f \( -name "*.yaml" -o -name "*.yml" -o -name "config" \) 2>/dev/null | \
        fzf --ansi \
            --prompt="Select Kubeconfig > " \
            --preview "head -n 20 {}" \
            --height=40% \
            --layout=reverse \
            --border)

    if [ -n "$SELECTED_CONFIG" ]; then
        export KUBECONFIG="$SELECTED_CONFIG"
        echo "Successfully set KUBECONFIG to: $KUBECONFIG"
        local CONTEXT
        CONTEXT=$(kubectl config current-context 2>/dev/null)
        echo "Active Context: ${CONTEXT:-'None'}"
    else
        echo "No config selected."
    fi
}

# ============================================================================
# External Tool Initialization
# ============================================================================

# Atuin detects blesh via BLE_VERSION and registers its own blesh-compatible
# key bindings via BLE_ONLOAD — do not pass --disable-up-arrow here.
eval "$(atuin init bash)"

export HISTSIZE=10000
export HISTFILESIZE=20000
export HISTCONTROL=ignoreboth
export HISTTIMEFORMAT="%F %T "

command -v direnv &>/dev/null && eval "$(direnv hook bash)"
command -v zoxide &>/dev/null && eval "$(zoxide init bash)"

if command -v carapace &>/dev/null; then
    source <(carapace _carapace)
fi

# ============================================================================
# Prompt (set before ble-attach so blesh picks it up)
# ============================================================================

PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND;}set_prompt"

# Attach blesh at the very end of .bashrc
[[ ${BLE_VERSION-} ]] && ble-attach
