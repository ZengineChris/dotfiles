-- nvim-treesitter v1.x: the old configs module is gone.
-- Neovim's built-in treesitter handles highlighting automatically.
-- This plugin now only manages parser installation.
local ok, ts = pcall(require, 'nvim-treesitter')
if ok then
    ts.setup()

    -- Install parsers after startup so the plugin is fully loaded.
    -- Run :TSUpdate to update parsers.
    vim.schedule(function()
        ts.install({ 'c', 'lua', 'vim', 'vimdoc', 'query', 'go', 'javascript', 'rust' })
    end)
end

-- Disable treesitter highlighting for large files (>100KB) for performance.
vim.api.nvim_create_autocmd('FileType', {
    callback = function(args)
        local max_filesize = 100 * 1024
        local _, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(args.buf))
        if stats and stats.size > max_filesize then
            vim.treesitter.stop(args.buf)
        end
    end,
})
