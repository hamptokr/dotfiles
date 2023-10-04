local wezterm = require("wezterm")

return {
	font = wezterm.font("Berkeley Mono"),
	font_size = 14,
	color_scheme = "nord",
	hide_tab_bar_if_only_one_tab = true,

	window_background_image = "/Users/kramer/wallpapers/nord_lake.png",
	window_background_image_hsb = {
		-- Darken the background image by reducing it to 1/3rd
		brightness = 0.08,

		-- You can adjust the hue by scaling its value.
		-- a multiplier of 1.0 leaves the value unchanged.
		hue = 1.0,

		-- You can adjust the saturation also.
		saturation = 1.0,
	},
}
