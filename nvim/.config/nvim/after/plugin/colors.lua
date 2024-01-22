function ColorMyPencils(color)
	color = color or "simple-dark"
	vim.cmd.colorscheme(color)
end

ColorMyPencils()
