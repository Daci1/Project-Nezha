{ pkgs, lib, ... }:

{
	imports = [ 
	  ./aesthetics.nix
	  ./binds.nix
	  ./env.nix
	  ./monitors.nix
	  ./window_rules.nix
	  ./workspaces.nix

	  ./hypridle.nix
	  ./hyprlock.nix
	  ./hyprsunset.nix
	  ./wlogout.nix
	  ../waybar
	  ../kitty.nix
	];
	home.packages = with pkgs; [

		grim
		slurp
		wl-clipboard

		swww
		swaynotificationcenter

		waybar	
		rofi	
		hypridle
		hyprlock
		hyprsysteminfo
		wlogout	

		libnotify
		swayosd
    hyprpolkitagent

    # Others
		waypaper
    hyprpicker

	];

	wayland.windowManager.hyprland = {
		enable = true;
		portalPackage = null;
		settings = {
		  "exec-once" = [
			  "waybar"
			  "swaync"
			  "solaar --window=hide --restart-on-wake-up"
			  "swww-daemon"
			  "swayosd-server"
			  "flatpak run com.discordapp.Discord --start-minimized"
        "obs --startreplaybuffer"
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

		  dwindle = {
		  # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
			  pseudotile = "yes"; # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
		    	  preserve_split = "yes"; # you probably want this
		  };

		  master = {
		  # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
			  new_status = "master"; 
			  mfact = 0.50;
			  orientation = "center";
		  };

		  misc = {
		  # See https://wiki.hyprland.org/Configuring/Variables/ for more
			  force_default_wallpaper = -1; # Set to 0 or 1 to disable the anime mascot wallpapers
		          focus_on_activate = true;
		  # dpms mouse and keyboard toggle on will awake the monitors if DPMS is set to off (disabled monitors)
			  key_press_enables_dpms = false;
			  mouse_move_enables_dpms = true; 
		  };
		};
	};
}
