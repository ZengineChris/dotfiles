local Remap = require("zenginechris.keymap")
local nnoremap = Remap.nnoremap

nnoremap("<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })



nnoremap("<C-d>", "<C-d>zz")
nnoremap("<C-u>", "<C-u>zz")
nnoremap("n", "nzzzv")
nnoremap("N", "Nzzzv")


nnoremap('<leader>ww',function() vim.lsp.buf.format() end) 
