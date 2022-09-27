
-- vim.cmd[[colorscheme tokyonight]]


vim.g.catppuccin_flavour = "macchiato" -- latte, frappe, macchiato, mocha

require("catppuccin").setup({
    transparent_background = false,
    integrations = {
        telescope = true,
        treesitter = true,
        treesitter_context = true,
        nvimtree = true,
        gitgutter = true,
    }
})

vim.cmd [[colorscheme catppuccin]]

vim.g.gruvbox_contrast_dark = 'hard'
vim.g.tokyonight_transparent_sidebar = true
vim.g.tokyonight_transparent = true
vim.g.gruvbox_invert_selection = '0'
vim.opt.background = "dark"
