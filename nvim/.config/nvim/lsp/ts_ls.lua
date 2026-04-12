return {
    cmd = {
        "typescript-language-server",
        "--stdio",
    },
    filetypes = {
        "javascript",
    },
    root_markers = {
        ".git",
    },
    settings = {
    },

    single_file_support = true,
    log_level = vim.lsp.protocol.MessageType.Warning,
}
