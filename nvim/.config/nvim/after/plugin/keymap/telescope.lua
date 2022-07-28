local Remap = require("zenginechris.keymap")
local nnoremap = Remap.nnoremap

nnoremap("<leader>ff", function()
    require('telescope.builtin').find_files()
end)
nnoremap("<leader>fg", function()
    require('telescope.builtin').git_files()
end)
--nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
--nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
--nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
--nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>
