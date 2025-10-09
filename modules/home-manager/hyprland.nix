{ pkgs, lib, ... }:

{
	home.packages = with pkgs; [
		waybar	
		rofi	
		kitty	
		wlogout	
	];

	wayland.windowManager.hyprland = {
		enable = false;
	};
}
