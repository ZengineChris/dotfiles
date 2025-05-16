export def darwin-switch [
    name: string
    mode: string
] {
    if "debug" == $mode {
        darwin-rebuild switch --flake $".#($name)" --show-trace --verbose
    } else {
        darwin-rebuild switch --flake $".#($name)"
    }
}

export def darwin-rollback [] {
    darwin-rebuild --rollback
}
