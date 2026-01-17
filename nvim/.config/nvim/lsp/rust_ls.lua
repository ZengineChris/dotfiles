return {
    cmd = {
        "rust-analyzer",
    },
    filetypes = {
        "rust",
    },
    root_markers = {
        ".git",
        "Cargo.toml",
    },
    settings = {
        ["rust-analyzer"] = {
            cargo = { targetDir = true },
            check = { command = "clippy" },
        },
    },
    single_file_support = true,
    log_level = vim.lsp.protocol.MessageType.Warning,
}
