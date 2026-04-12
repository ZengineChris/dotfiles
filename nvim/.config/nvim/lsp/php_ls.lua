return {
    cmd = {
        "phpactor",
        "language-server",
    },
    filetypes = {
        "php",
    },
    root_markers = {
        "composer.json",
        ".git",
    },
    settings = {
        phpactor = {
            language_server_phpstan = {
                enabled = false,
            },
            language_server_psalm = {
                enabled = false,
            },
        },
    },
    -- Note: phpactor doesn't support formatting.command like nixd
    -- Add formatting via conform.nvim in your setup:
    -- formatters_by_ft = { php = { "pint" } }
    -- formatters = { pint = { command = "./vendor/bin/pint", args = { "$FILENAME" }, stdin = false } }
    single_file_support = true,
    log_level = vim.lsp.protocol.MessageType.Warning,
}

