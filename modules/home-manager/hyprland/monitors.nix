{ pkgs, lib, ... }:

{
	wayland.windowManager.hyprland = {
		settings = {
			monitor = "DP-3,3440x1440@165,0x0,1.25,bitdepth,8, vrr, 3";

				xwayland = {
					force_zero_scaling = true;
				};
		};
	};
}

