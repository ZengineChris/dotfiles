vim.g.mapleader = " "


-- Functional wrapper for mapping custom keybindings
function map(mode, lhs, rhs, opts)
    local options = { noremap = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- Colemak: hjkl>mnei, i>t
--map("n", "m", "h")          -- move Left
--map("n", "n", "gj")         -- move Down (g to allow move within wrapped lines)
--map("n", "e", "gk")         -- move Up (g to allow move within wrapped lines)
--map("n", "i", "l")          -- move Right
--map("n", "t", "i")          -- (t)ype           replaces (i)nsert
--map("n", "T", "I")          -- (T)ype at bol    replaces (I)nsert
--map("n", "E", "e")          -- end of word      replaces (e)nd
--map("n", "h", "n")          -- next match       replaces (n)ext
--map("n", "k", "N")          -- previous match   replaces (N) prev

-- Visual Colemak
--map("v", "m", "h")          -- move Left
--map("v", "n", "gj")         -- move Down (g to allow move within wrapped lines)
--map("v", "e", "gk")         -- move Up (g to allow move within wrapped lines)
--map("v", "I", "l")          -- move Right - shifted to fix [v]isual[i]n[...]

-- Enter commands without pressing shift
--map("n", ";", ":")
--map("n", ":", ";")

-- Quickly return to normal_mode
--map("i", ",n", "<Esc>")

-- Ctrl+up/down to page up/down
--map("n", "<C-n>", "<C-f>M")  -- page down
--map("n", "<C-e>", "<C-b>M")  -- page up


vim.keymap.set("n","e","k") 
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")


-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({"n", "v"}, "<leader>d", [["_d]])

-- This is going to get me cancelled
vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })
