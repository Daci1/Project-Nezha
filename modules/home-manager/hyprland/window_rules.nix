{ pkgs, lib, ... }:

{
	wayland.windowManager.hyprland = {
		settings = {

			windowrulev2 = [
				"suppressevent maximize, class:.*" # You'll probably like this.
				# window rules - move to workspace
				"workspace 2, class:^([Ff]irefox|org.mozilla.firefox|[Ff]irefox-esr)$"
				"workspace 3, class:^([Dd]iscord|[Dd]iscordCanary|com.discordapp.DiscordCanary)$"
				"workspace 4 silent, class:^([Ss]team)$"
				"workspace 5, class:^([Dd]ocker\\ Desktop)$"
				"workspace 6, initialTitle:^(gsr\\ ui)$"

				# window rules - float
				"float, class:^(pavucontrol|org.pulseaudio.pavucontrol)$"
				"float, class:^(CUSTOM_CLASS_NETWORK_TUI)$"
				"float, class:^(steam)$, title:negative:^Steam$"

				"float, title:^(gsr\\ ui)$"
				"float, initialTitle:^(gsr\\ ui)$"
				"norounding, title:^(gsr\\ ui)$"

				# window rules - center
				"center, class:^(pavucontrol|org.pulseaudio.pavucontrol)"

				# window rules - size
				"size 60% 80%, class:^(pavucontrol|org.pulseaudio.pavucontrol)$"
				"size 50% 80%, class:^(CUSTOM_CLASS_NETWORK_TUI)$"

				# window rules - opacity
				"opacity 0.9 0.8, class:^(kitty)$"

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
			];

			windowrule = [
				"workspace 1, class:^(steam_app_.*)"
			];
		};
	};
}


