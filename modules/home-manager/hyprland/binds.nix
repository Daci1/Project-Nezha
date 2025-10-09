{ pkgs, lib, ... }:

{
	wayland.windowManager.hyprland = {
		settings = {
			"$mainMod" = "SUPER";


			bind = [

				# Set programs that you use
				"$mainMod, T, exec, kitty"
				"$mainMod, Q, killactive, "
				"$mainMod, M, exit,"
				"$mainMod, E, exec, thunar"
				"$mainMod, V, togglefloating, "
				"$mainMod, R, exec, rofi -show drun"
				"$mainMod, P, pseudo,"
				"$mainMod, J, togglesplit,"
				"$mainMod, C, centerwindow,"
				"$mainMod SHIFT, P, pin,"

				# Move focus with mainMod + arrow keys
				"$mainMod, left, movefocus, l"
				"$mainMod, right, movefocus, r"
				"$mainMod, up, movefocus, u"
				"$mainMod, down, movefocus, d"


				# Switch workspaces with mainMod + [0-9]
				"$mainMod, 1, workspace, 1"
				"$mainMod, 2, workspace, 2"
				"$mainMod, 3, workspace, 3"
				"$mainMod, 4, workspace, 4"
				"$mainMod, 5, workspace, 5"
				"$mainMod, 6, workspace, 6"
				"$mainMod, 7, workspace, 7"
				"$mainMod, 8, workspace, 8"
				"$mainMod, 9, workspace, 9"
				"$mainMod, 0, workspace, 10"

				# Move active window to a workspace with mainMod + SHIFT + [0-9]
				"$mainMod SHIFT, 1, movetoworkspace, 1"
				"$mainMod SHIFT, 2, movetoworkspace, 2"
				"$mainMod SHIFT, 3, movetoworkspace, 3"
				"$mainMod SHIFT, 4, movetoworkspace, 4"
				"$mainMod SHIFT, 5, movetoworkspace, 5"
				"$mainMod SHIFT, 6, movetoworkspace, 6"
				"$mainMod SHIFT, 7, movetoworkspace, 7"
				"$mainMod SHIFT, 8, movetoworkspace, 8"
				"$mainMod SHIFT, 9, movetoworkspace, 9"
				"$mainMod SHIFT, 0, movetoworkspace, 10"

				# Scroll through existing workspaces with mainMod + scroll
				"$mainMod, mouse_down, workspace, e+1"
				"$mainMod, mouse_up, workspace, e-1"

				# Waybar shortcuts
				"$mainMod SHIFT, B, exec, killall waybar && waybar"
				"$mainMod, B, exec, killall waybar || waybar"

				"ALT, Tab, workspace, previous"
				"$mainMod SHIFT, S, exec, grim -g \"$(slurp)\" | wl-copy && notify-send \"Screenshot saved to clipboard\"" #screenshot
				"$mainMod SHIFT, R, exec, killall solaar; solaar -w=hide"
				"$mainMod, L, exec, wlogout"
				"$mainMod, F, fullscreen"

				#Wallpaper selector
				#"$mainMod SHIFT, W, exec, ~/hypr-dots/hypr/hyprland/scripts/wallpaperSelect.sh" #TODO: fix this
			];

			bindm = [
				# Move/resize windows with mainMod + LMB/RMB and dragging
				"$mainMod, mouse:272, movewindow"
					"$mainMod, mouse:273, resizewindow"
			];


			bindle = [
				# Media/Audio Keybinds
				", XF86AudioRaiseVolume, exec, swayosd-client --output-volume raise"
				", XF86AudioLowerVolume, exec, exec  swayosd-client --output-volume lower"
				",XF86AudioMute, exec, swayosd-client --output-volume mute-toggle"
				", XF86AudioPlay, exec, playerctl play-pause"
				", XF86AudioNext, exec, playerctl next"
				", XF86AudioPrev, exec, playerctl previous"
			];

		};
	};
}
