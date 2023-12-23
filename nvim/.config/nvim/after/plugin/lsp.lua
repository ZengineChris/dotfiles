local lsp = require("lsp-zero")

lsp.preset("recommended")

lsp.ensure_installed({
    'tsserver',
    'eslint',
    'rust_analyzer',
    'gopls'
})

local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    ["<C-Space>"] = cmp.mapping.complete(),
})

-- disable completion with tab
-- this helps with copilot setup
cmp_mappings['<Tab>'] = nil
cmp_mappings['<S-Tab>'] = nil

lsp.setup_nvim_cmp({
    mapping = cmp_mappings
})

lsp.set_preferences({
    suggest_lsp_servers = false,
    sign_icons = {
        error = 'E',
        warn = 'W',
        hint = 'H',
        info = 'I'
    }
})



vim.filetype.add({
    extension = {
        tilt = "tilt",
    }
})
vim.filetype.add({
    extension = {
        tiltfile = "Tiltfile",
    }
})

vim.diagnostic.config({
    virtual_text = true,
})


local lsp_configurations = require('lspconfig.configs')
local util = require 'lspconfig.util'
if not lsp_configurations.starlark_lsp then
    lsp_configurations.starlark_lsp = {
        default_config = {
            name = 'starlark_lsp',
            cmd = { 'tilt', 'lsp', 'start' },
            filetypes = { "Tiltfile", "tiltfile" },
            root_dir = util.root_pattern("Tiltfile"),
        }
    }
end
require('lspconfig').starlark_lsp.setup({})

lsp.on_attach(function(client, bufnr)
    local opts = { buffer = bufnr, remap = false }

    if client.name == "eslint" then
        vim.cmd.LspStop('eslint')
        return
    end

    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts)
    vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
    vim.keymap.set("n", "[d", vim.diagnostic.goto_next, opts)
    vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, opts)
    vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, opts)
    vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
end)

lsp.setup()


vim.cmd [[
  augroup DOSIniFileType
    autocmd!
    autocmd BufNewFile,BufRead Tiltfile setfiletype tiltfile
  augroup END
]]



require("lspconfig").tailwindcss.setup({
    filetypes = {
        'templ',
        'html',
        'gohtml'
        -- include any other filetypes where you need tailwindcss
    },
    init_options = {
        userLanguages = {
            templ = "html"
        }
    }
})
