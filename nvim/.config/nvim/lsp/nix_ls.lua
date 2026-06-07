return {
    cmd = { "nil" },
    filetypes = { "nix" },
    root_markers = {
        ".git",
        "flake.nix",
    },
    settings = {
        ["nil"] = {
            formatting = {
                command = { "alejandra" },
            },
        },
    },
    single_file_support = true,
}
