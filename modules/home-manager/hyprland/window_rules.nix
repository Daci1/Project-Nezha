{ pkgs, lib, ... }:

{
	wayland.windowManager.hyprland = {
		settings = {

			windowrule = [
				"suppressevent maximize, class:.*" # You'll probably like this.
				# window rules - move to workspace
				"workspace 1, class:^(steam_app_.*)"
				"workspace 2, class:^([Ff]irefox|org.mozilla.firefox|[Ff]irefox-esr)$"
				"workspace 3, class:^([Dd]iscord|[Dd]iscordCanary|com.discordapp.DiscordCanary)$"
				"workspace 4 silent, class:^([Ss]team)$"
				"workspace 5, class:^([Dd]ocker\\ Desktop)$"
				"workspace 6, initialTitle:^(gsr\\ ui)$"

				# window rules - float
				"float, class:^(pavucontrol|org.pulseaudio.pavucontrol)$"
				"float, class:^(CUSTOM_CLASS_NETWORK_TUI)$"
				"float, class:^(steam)$, title:negative:^Steam$"
				"float, class:^(waypaper)$"
				"float, class:^(com.network.manager)$"
				"float, class:^(.blueman-manager-wrapped)$"

				"float, title:^(gsr\\ ui)$"
				"float, initialTitle:^(gsr\\ ui)$"
				"norounding, title:^(gsr\\ ui)$"

				# window rules - center
				"center, class:^(pavucontrol|org.pulseaudio.pavucontrol)"
				"center, class:^(waypaper)"

				# window rules - size
				"size 60% 80%, class:^(pavucontrol|org.pulseaudio.pavucontrol)$"
				"size 50% 80%, class:^(CUSTOM_CLASS_NETWORK_TUI)$"
				"size 35% 60%, class:^(waypaper)$"
				"size 35% 60%, class:^(com.network.manager)$"
				"size 35% 60%, class:^(.blueman-manager-wrapped)$"

				# window rules - opacity
				"opacity 0.9 0.8, class:^(kitty)$"
				"opacity 0.8, class:^(waypaper)$"

				# picture-in-picture rules
				## firefox
				"float, class:^(firefox)$, title:^(Picture-in-Picture)$"
				"pin, class:^(firefox)$, title:^(Picture-in-Picture)$"
				"move 2231 78, class:^(firefox)$, title:^(Picture-in-Picture)$"
				"size 500 280, class:^(firefox)$, title:^(Picture-in-Picture)$"

				## discord
				"float, class:^([Dd]iscord|[Dd]iscordCanary|com.discordapp.DiscordCanary)$, initialTitle:^(Discord\\ Popout)$"
				"pin, class:^([Dd]iscord|[Dd]iscordCanary|com.discordapp.DiscordCanary)$, initialTitle:^(Discord\\ Popout)$"
				"move 2206 78, class:^([Dd]iscord|[Dd]iscordCanary|com.discordapp.DiscordCanary)$, initialTitle:^(Discord\\ Popout)$"
				"size 525 297, class:^([Dd]iscord|[Dd]iscordCanary|com.discordapp.DiscordCanary)$, initialTitle:^(Discord\\ Popout)$"

				#render unfocused
				"renderunfocused, workspace:1"
			];
		};
	};
}


