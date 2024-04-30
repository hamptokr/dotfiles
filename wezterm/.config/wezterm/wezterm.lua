local wezterm = require("wezterm")

return {
	font = wezterm.font("Iosevka"),
	font_size = 18,
	color_scheme = "Gruber (base16)",
	hide_tab_bar_if_only_one_tab = true,
	window_padding = {
		left = 3,
		right = 2,
		top = 3,
		bottom = 0,
	},
}
