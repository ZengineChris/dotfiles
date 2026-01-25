#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# ============================================================================
# Environment Variables
# ============================================================================

# Set editor
export EDITOR="nvim"
export VISUAL="nvim"  # Best practice: set both EDITOR and VISUAL

# PATH configuration - consolidated and deduplicated
# Note: Avoid overwriting PATH, append/prepend instead
export PATH="$HOME/.local/bin:$HOME/.cargo/bin:$PATH"

# Carapace bridges configuration
export CARAPACE_BRIDGES='zsh,fish,bash,inshellisense'

# ============================================================================
# Shell Options
# ============================================================================

# Enable useful bash options
shopt -s histappend        # Append to history file, don't overwrite
shopt -s checkwinsize      # Check window size after each command
shopt -s cmdhist           # Save multi-line commands in one history entry
shopt -s globstar 2>/dev/null  # Enable ** for recursive globbing (bash 4+)

# ============================================================================
# Aliases
# ============================================================================

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias v='nvim'

# ============================================================================
# Functions
# ============================================================================

# Git branch function
parse_git_branch() {
    git rev-parse --abbrev-ref HEAD 2>/dev/null
}

# Prompt configuration
set_prompt() {
    local last_status=$?

    # Replace home directory with ~
    local dir="${PWD/#$HOME/\~}"

    # Path segment (blue)
    local path_segment="\[\033[34m\]${dir}\[\033[0m\]"

    # Git branch segment (yellow)
    local git_branch
    git_branch=$(parse_git_branch)
    local git_segment=""
    if [ -n "$git_branch" ]; then
        git_segment=" on \[\033[33m\]${git_branch}\[\033[0m\]"
    fi

    # Nix/direnv indicator (cyan)
    # Only show [nix] when IN_NIX_SHELL is "pure" or "impure" (set by nix-shell/nix develop)
    local nix_segment=""
    if [[ ${IN_NIX_SHELL-} == "pure" || ${IN_NIX_SHELL-} == "impure" ]]; then
        nix_segment=" \[\033[36m\][nix]\[\033[0m\]"
    elif [ -n "${DIRENV_DIR-}" ]; then
        nix_segment=" \[\033[36m\][direnv]\[\033[0m\]"
    fi

    # Kubernetes context (magenta) - only when KUBECONFIG is explicitly set
    local k8s_segment=""
    if [ -n "${KUBECONFIG-}" ] && command -v kubectl &>/dev/null; then
        local k8s_ctx
        k8s_ctx=$(kubectl config current-context 2>/dev/null)
        if [ -n "$k8s_ctx" ]; then
            k8s_segment=" \[\033[35m\][k8s:${k8s_ctx}]\[\033[0m\]"
        fi
    fi

    # Status symbol (green checkmark or red X)
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
    local SELECTED_CONFIG=$(find "${SEARCH_PATHS[@]}" -type f \( -name "*.yaml" -o -name "*.yml" -o -name "config" \) 2>/dev/null | \
        fzf --ansi \
            --prompt="Select Kubeconfig > " \
            --preview "head -n 20 {}" \
            --height=40% \
            --layout=reverse \
            --border)

    if [ -n "$SELECTED_CONFIG" ]; then
        export KUBECONFIG="$SELECTED_CONFIG"
        echo "Successfully set KUBECONFIG to: $KUBECONFIG"
        
        local CONTEXT=$(kubectl config current-context 2>/dev/null)
        echo "Active Context: ${CONTEXT:-'None'}"
    else
        echo "No config selected."
    fi
}

# ============================================================================
# External Tool Initialization
# ============================================================================

# Blesh (should be loaded early, before PROMPT_COMMAND)
[[ -f /usr/share/blesh/ble.sh ]] && source /usr/share/blesh/ble.sh

# Atuin initialization - BEFORE history settings
eval "$(atuin init bash)"

# History configuration - AFTER Atuin
# Note: Atuin manages its own history, so these are minimal
export HISTSIZE=10000
export HISTFILESIZE=20000
export HISTCONTROL=ignoreboth  # Removed erasedups for Atuin compatibility
export HISTTIMEFORMAT="%F %T "

# Direnv hook
eval "$(direnv hook bash)"
# Zoxide initialization
eval "$(zoxide init bash)"
# Mise hook 
eval "$(mise activate bash)"

# Carapace completion
if command -v carapace &>/dev/null; then
    source <(carapace _carapace)
fi

# ============================================================================
# Prompt Configuration (must be after blesh)
# ============================================================================

# Append to PROMPT_COMMAND so set_prompt runs after direnv's hook
# This ensures environment variables are updated before the prompt is set
PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND;}set_prompt"
