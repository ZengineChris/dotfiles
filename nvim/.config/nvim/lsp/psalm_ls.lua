return {
    cmd = { 'psalm', '--language-server' },
    filetypes = { 'php' },
    root_markers = {
        ".git",
    },
    settings = {
    },
    single_file_support = true,
    log_level = vim.lsp.protocol.MessageType.Warning,
}
