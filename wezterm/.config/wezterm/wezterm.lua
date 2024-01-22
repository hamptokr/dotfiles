local wezterm = require("wezterm")

return {
	font = wezterm.font("Berkeley Mono"),
	font_size = 16,
	color_scheme = "Grayscale Dark (base16)",
	hide_tab_bar_if_only_one_tab = true,
	window_padding = {
		left = 3,
		right = 2,
		top = 3,
		bottom = 0,
	},
}
