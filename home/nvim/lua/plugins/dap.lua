require('dapui').setup()
require('dap-go').setup()
require('dap-ruby').setup()
require('nvim-dap-virtual-text').setup()
vim.fn.sign_define('DapBreakpoint', {
    text = '🔴',
    texthl = 'DapBreakpoint',
    linehl = 'DapBreakpoint',
    numhl =
    'DapBreakpoint'
})

-- Debugger
vim.api.nvim_set_keymap("n", "<leader>dt", ":lua require('dapui').toggle()<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>db", ":DapToggleBreakpoint<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>dc", ":DapContinue<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>dr", ":lua require('dapui').open({reset = true})<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>ht", ":lua require('harpoon.ui').toggle_quick_menu()<CR>", { noremap = true })

local dap = require('dap')
