{ pkgs, lib, ... }:

{
	services.hypridle = {
	  enable = true;
	  package = pkgs.hypridle;
	  settings = {
		  general = {
		    lock_cmd = "pidof hyprlock || hyprlock";      # dbus/sysd lock command (loginctl lock-session)
		    before_sleep_cmd = "loginctl lock-session";   # lock before suspend
		    after_sleep_cmd = "hyprctl dispatch dpms on"; # command ran after sleep
		    ignore_dbus_inhibit = false;                # whether to ignore dbus-sent idle-inhibit requests (used by e.g. firefox or steam)
		  };

		  listener = [
		  {
		    timeout = 180;                          # 3 min 
		    on-timeout = "hyprctl dispatch dpms off"; # turn off monitors
		    on-resume = "hyprctl dispatch dpms on";   # command to run when activity is detected after timeout has fired.
		  }
		  {
		    timeout = 300;                      # 5min
		    on-timeout = "loginctl lock-session"; # lock screen when timeout has passed
		  }
		  {
		    timeout = 5400;                 # 90 min
		    on-timeout = "systemctl suspend"; # suspend pc
		  }
		  ];
	  };
	};
}

