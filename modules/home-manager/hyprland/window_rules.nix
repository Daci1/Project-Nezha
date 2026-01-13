{ pkgs, lib, ... }:

{
  wayland.windowManager.hyprland = {
    settings = {

      windowrule = [
      {
        name = "Default Rule";
        suppress_event = "maximize";
        match = {
          class = ".*";
        };
      }

      {
        name = "Steam Games Workspace";
        workspace = 1;
        center = true;
        match = {
          class = "^(steam_app_.*)";
        };
      }

      {
        name = "Firefox Rules";
        workspace = 2;
        match = {
          class = "^([Ff]irefox|org.mozilla.firefox|[Ff]irefox-esr)$";
        };
      }

      {
        name = "Discord Rules";
        workspace = 3;
        match = {
          class = "^([Dd]iscord|[Dd]iscordCanary|com.discordapp.DiscordCanary)$";
        };
      }

      {
        name = "Steam Silent Rules";
        workspace = "4 silent";
        match = {
          class = "^([Ss]team)$";
        };
      }

      {
        name = "Docker Rules";
        workspace = 5;
        match = {
          class = "^([Dd]ocker\\ Desktop)$";
        };
      }

      {
        name = "Minecraft Launcher Rules";
        workspace = 6;
        match = {
          class = "^(org.prismlauncher.PrismLauncher)$";
        };
      }

      {
        name = "GSR UI Rules";
        workspace = 7;
        float = true;
        rounding = 0;
        match = {
          initial_title = "^(gsr\\ ui)$";
        };
      }

      {
        name = "Sound Settings";
        float = true;
        center = true;
        size = "(monitor_w*0.6) (monitor_h*0.8)";
        match = {
          class = "^(pavucontrol|org.pulseaudio.pavucontrol)$";
        };
      }

      {
        name = "Steam Rules";
        float = true;
        match = {
          class = "^(steam)$";
          title = "^(?!Steam$)";
        };
      }

      {
        name = "Waypaper Rules";
        float = true;
        size = "(monitor_w*0.35) (monitor_h*0.6)";
        opacity = 0.8;
        center = true;
        match = {
          class = "^(waypaper)$";
        };
      }

      {
        name = "Network Manager Rules";
        float = true;
        size = "(monitor_w*0.35) (monitor_h*0.6)";
        match = {
          class = "^(com.network.manager)$";
        };
      }

      {
        name = "Blueman Manager Rules";
        float = true;
        size = "(monitor_w*0.35) (monitor_h*0.6)";
        match = {
          class = "^(.blueman-manager-wrapped)$";
        };
      }

      {
        name = "Kitty Rules";
        opacity = "0.9 0.8";
        match = {
          class = "^(kitty)$";
        };
      }

      {
        name = "Picture in Picture Firefox";
        float = true;
        pin = true;
        move = "2206 78";
        size = "500 280";
        match = {
          class = "^(firefox)$";
          title = "^(Picture-in-Picture)$";
        };
      }

      {
        name = "Picture in Picture Discord";
        float = true;
        pin = true;
        move = "2206 78";
        size = "525 297";
        match = {
          class = "^([Dd]iscord|[Dd]iscordCanary|com.discordapp.DiscordCanary)$";
          initial_title = "^(Discord\\ Popout)$";
        };
      }

      {
        name = "Always Active Workspace 1";
        render_unfocused = true;
        match = {
          workspace = 1;
        };
      }
      ];
    };
  };
}
