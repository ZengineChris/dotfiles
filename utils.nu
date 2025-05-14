export def darwin-switch [
    mode: string
] {
    if "debug" == $mode {
        darwin-rebuild switch --flake . --show-trace --verbose
    } else {
        darwin-rebuild switch --flake .
    }
}

export def darwin-rollback [] {
    darwin-rebuild --rollback
}
