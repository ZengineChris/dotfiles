local Remap = require("zenginechris.keymap")
local nnoremap = Remap.nnoremap

nnoremap("<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })
