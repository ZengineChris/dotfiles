vim.pack.add({
    -- Shared dependencies
    'https://github.com/nvim-tree/nvim-web-devicons',
    'https://github.com/nvim-lua/plenary.nvim',

    -- UI
    'https://github.com/nvim-lualine/lualine.nvim',
    'https://github.com/catppuccin/nvim',

    -- Navigation
    { src = 'https://github.com/ThePrimeagen/harpoon', version = 'harpoon2' },
    'https://github.com/stevearc/oil.nvim',

    -- Telescope
    { src = 'https://github.com/nvim-telescope/telescope.nvim', version = '0.1.x' },
    'https://github.com/nvim-telescope/telescope-symbols.nvim',
    -- NOTE: after install, run `make` in the plugin directory:
    -- ~/.local/share/nvim/site/pack/core/opt/telescope-fzf-native.nvim/
    'https://github.com/nvim-telescope/telescope-fzf-native.nvim',

    -- Treesitter
    -- NOTE: after install, run :TSUpdate inside Neovim
    'https://github.com/nvim-treesitter/nvim-treesitter',
    'https://github.com/nvim-treesitter/nvim-treesitter-textobjects',

    -- DAP
    'https://github.com/mfussenegger/nvim-dap',
    'https://github.com/rcarriga/nvim-dap-ui',
    'https://github.com/nvim-neotest/nvim-nio',
    'https://github.com/theHamsta/nvim-dap-virtual-text',

    -- Completion
    'https://github.com/saghen/blink.cmp',
})

