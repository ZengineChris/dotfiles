export def darwin-switch [
    name: string
    mode: string
] {
    if "debug" == $mode {
        sudo darwin-rebuild switch --flake $".#($name)" --show-trace --verbose
    } else {
        sudo darwin-rebuild switch --flake $".#($name)"
    }
}

export def darwin-rollback [] {
    sudo darwin-rebuild --rollback
}
