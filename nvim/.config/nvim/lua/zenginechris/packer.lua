local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    packer_bootstrap = fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim',
        install_path })
    vim.cmd [[packadd packer.nvim]]
end

vim.cmd [[packadd packer.nvim]] -- packadd packer module

return require('packer').startup(function(use)

    use("wbthomason/packer.nvim")
    use("TimUntersberger/neogit")
    use("nvim-lua/plenary.nvim")

    use("onsails/lspkind-nvim")

    use {
        'VonHeikemen/lsp-zero.nvim',
        requires = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' },
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'saadparwaiz1/cmp_luasnip' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-nvim-lua' },

            -- Snippets
            { 'L3MON4D3/LuaSnip' },
            { 'rafamadriz/friendly-snippets' },
        }
    }


    -- Formatting
    use("jose-elias-alvarez/null-ls.nvim")

    use("nvim-lua/popup.nvim")
    use("nvim-telescope/telescope.nvim")

    -- Colors and Themes
    use 'folke/tokyonight.nvim'
    use { "catppuccin/nvim", as = "catppuccin" }

    use { 'tzachar/cmp-tabnine', run = './install.sh', requires = 'hrsh7th/nvim-cmp' }
    ---use("glepnir/lspsaga.nvim")
    use("simrat39/symbols-outline.nvim")
    use {
        'lewis6991/gitsigns.nvim',
        config = function()
            require('gitsigns').setup()
        end
    }


    use {
        'kyazdani42/nvim-tree.lua',
        requires = {
            'kyazdani42/nvim-web-devicons', -- optional, for file icons
        },
        tag = 'nightly' -- optional, updated every week. (see issue #1193)
    }
    use("nvim-treesitter/nvim-treesitter", {
        run = ":TSUpdate"
    })

    use("nvim-treesitter/playground")
    use("romgrk/nvim-treesitter-context")
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }

    --use("mfussenegger/nvim-dap")
    --use("rcarriga/nvim-dap-ui")
    --use("theHamsta/nvim-dap-virtual-text")
    use("folke/zen-mode.nvim")
    use('mbbill/undotree')
    use('ThePrimeagen/harpoon')

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
        require('packer').sync()
    end
end)
