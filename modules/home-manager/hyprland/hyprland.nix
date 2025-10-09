{ pkgs, lib, ... }:

{
	imports = [ 
	  ./aesthetics.nix
	  ./binds.nix
	  ./env.nix
	  ./monitors.nix
	  ./window_rules.nix
	  ./workspaces.nix
	];
	home.packages = with pkgs; [
		waybar	
		rofi	
		kitty	
		wlogout	
		grim
		slurp
		wl-clipboard
		swww
		swaynotificationcenter
		hypridle
		xfce.thunar
		libnotify
	];

	wayland.windowManager.hyprland = {
		enable = true;
		portalPackage = null;
		settings = {
		  "exec-once" = [
			  #~/hypr-dots/waybar/launch.sh
			  "swaync"
			  "solaar --window=hide --restart-on-wake-up"
			  "swww-daemon"
			  "swayosd-server"
			  "hypridle"
		  ];

		  input = {
			  kb_layout = "us";
			  kb_variant = "";
			  kb_model = "";
			  kb_options = "";
			  kb_rules = "";

			  follow_mouse = 1;

			  touchpad = {
				  natural_scroll = "no";
			  };

			  sensitivity = -0.75; # -1.0 to 1.0, 0 means no modification.
		  };
		  general = {
			  # See https://wiki.hyprland.org/Configuring/Variables/ for more

			  gaps_in = 5;
			  gaps_out = 20;
		          border_size = 2;
			  "col.active_border" = "rgba(a0a3a8aa)";
			  "col.inactive_border" = "rgb(171619)";

			  layout = "dwindle";

			  # Please see https://wiki.hyprland.org/Configuring/Tearing/ before you turn this on
			  allow_tearing = false;
		  };
		};
	};
}
