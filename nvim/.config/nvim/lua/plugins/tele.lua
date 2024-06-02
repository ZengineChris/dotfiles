-- require('telescope').load_extension('git_worktree')

require('telescope').setup {
  defaults = {
    layout_strategy = "horizontal",
    layout_config = {
      preview_width = 0.65,     
      horizontal = {
        size = {
          width = "95%",
          height = "95%",
        },
      },
    },
  pickers = {
    find_files = {
      theme = "dropdown",
    }
  },
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
        ["<C-j>"] = require('telescope.actions').move_selection_next,
        ["<C-k>"] = require('telescope.actions').move_selection_previous,
        ["<C-d>"] = require('telescope.actions').move_selection_previous,
      },
    },
  },
}



vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
