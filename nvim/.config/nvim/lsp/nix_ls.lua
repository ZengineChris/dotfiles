return {
    cmd = {
        "nixd",
    },
    filetypes = {
        "nix",
    },
    root_markers = {
        ".git",
    },
    -- settings = {
    --     Lua = {
    --         diagnostics = {
    --             --     disable = { "missing-parameters", "missing-fields" },
    --         },
    --     },
    -- },
    settings = {
        nixd = {
            nixpkgs = {
                expr = "import <nixpkgs> {} ",
            },
            formatting = {
                command = { "alejandra" },
            },
        },
    },

    single_file_support = true,
    log_level = vim.lsp.protocol.MessageType.Warning,
}
