{ pkgs, lib, ... }:

{
	programs.wlogout = {
	  enable = true;
	  package = pkgs.wlogout;
	  layout = [
	    {
		  "label" = "lock";
		  "action" = "nohup hyprlock & hyprctl dispatch dpms off";
		  "text" = "Lock";
		  "keybind" = "l";
	    }
	    {
		  "label" = "reboot";
		  "action" = "systemctl reboot";
		  "text" = "Reboot";
		  "keybind" = "r";
	    }
	    {
		  "label" = "shutdown";
		  "action" = "systemctl poweroff";
		  "text" = "Shutdown";
		  "keybind" = "s";
	    }
	    {
		  "label" = "logout";
		  "action" = "hyprctl dispatch exit";
		  "text" = "Logout";
		  "keybind" = "e";
	    }
	    {
		  "label" = "suspend";
		  "action" = "systemctl suspend";
		  "text" = "Suspend";
		  "keybind" = "u";
	    }
	    {
		  "label" = "hibernate";
		  "action" = "systemctl hibernate";
		  "text" = "Hibernate";
		  "keybind" = "h";
	    }
	  ];
	};
}
