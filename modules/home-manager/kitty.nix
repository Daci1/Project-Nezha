{ pkgs, ... }:

{
	programs.kitty= {
		enable = true;
		package = pkgs.kitty;
		settings = {
			# Base colors
			background = "#000000";
			foreground = "#f8f8f2";

			# Cursor
			cursor = "#bbbbbb";

			# Selection highlight
			selection_background = "#44475a";
			selection_foreground = "#1e1f28";

			# Black
			color0 = "#000000";
			color8 = "#545454";

			# Red
			color1 = "#ef2d56";
			color9 = "#ef2d56";

			# Green
			color2 = "#2ecc71";
			color10 = "#2ecc71";

			# Yellow
			color3 = "#f0fa8b";
			color11 = "#f0fa8b";

			# Blue
			color4 = "#7d5fff";
			color12 = "#7d5fff";

			# Magenta
			color5 = "#ff78c5";
			color13 = "#ff78c5";

			# Cyan
			color6 = "#7d5fff";
			color14 = "#7d5fff";

			# White
			color7 = "#bbbbbb";
			color15 = "#ffffff";

			#Other config
			confirm_os_window_close = 0;
		};
	};
}




