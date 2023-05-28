
function ColorMyPencils(color) 
	color = color or "nord"
	vim.cmd.colorscheme(color)

	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

end


vim.g.nord_cursor_line_number_background = 1


--ColorMyPencils()
