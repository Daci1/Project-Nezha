{ pkgs, lib, ... }:

let
  assetsDir = ../../../assets;
  defaultWallpaperPath = "${assetsDir}/wallpapers/blasphemous.jpg";
  lockScreenProfilePicturePath = "${assetsDir}/lockscreen/nezha.png";
  lockScreenTurnOffMonitorPicturePath = "${assetsDir}/lockscreen/monitor_off.png";
in
{
  programs.hyprlock = {
    enable = true;
    package = pkgs.hyprlock;
    settings = {
      background = {
        #monitor =
        path = defaultWallpaperPath;
        blur_passes = 2;
        contrast = 0.8916;
        brightness = 0.8172;
        vibrancy = 0.1696;
        vibrancy_darkness = 0.0;
      };

      # Password input field
      input-field = {
        #monitor =
        size = "200, 50";
        outline_thickness = 3;
        dots_size = 0.2; # Scale of input-field height, 0.2 - 0.8
        dots_spacing = 0.15; # Scale of dots' absolute size, 0.0 - 1.0
        dots_center = true;
        dots_rounding = -1; # -1 default circle, -2 follow input-field rounding
        outer_color = "rgb(151515)";
        inner_color = "rgb(FFFFFF)";
        font_color = "rgb(00, FF, 00)";
        fade_on_empty = false;
        fade_timeout = 1000; # Milliseconds before fade_on_empty is triggered.
        placeholder_text = "<i>Input Password...</i>"; # Text rendered in the input box when it's empty.
        hide_input = false;
        rounding = -1; # -1 means complete rounding (circle/oval)
        check_color = "rgb(204, 136, 34)";
        fail_color = "rgb(204, 34, 34)"; # if authentication failed, changes outer_color and fail message color
        fail_text = "<i>$FAIL <b>($ATTEMPTS)</b></i>"; # can be set to empty
        fail_transition = 300; # transition time in ms between normal outer_color and fail_color
        fail_timeout = 500;
        capslock_color = -1;
        numlock_color = -1;
        bothlock_color = -1; # when both locks are active. -1 means don't change outer color (same for above)
        invert_numlock = false; # change color if numlock is off
        swap_font_color = false; # see below
        position = "0, -200";
        halign = "center";
        valign = "center";
      };
      label = [
        {
          #monitor =
          #clock
          text = "cmd[update:1000] echo \"$TIME\"";
          color = "rgba(200, 200, 200, 1.0)";
          font_size = 55;
          font-family = "JetBrainsMono Nerd Font";
          position = "-100, 0";
          halign = "right";
          valign = "bottom";
          shadow_passes = 5;
          shadow_size = 10;
        }

        {
          #monitor =
          text = "$USER";
          color = "rgba(200, 200, 200, 1.0)";
          font_size = 20;
          font-family = "JetBrainsMono Nerd Font";
          position = "-100, 160";
          halign = "right";
          valign = "bottom";
          shadow_passes = 5;
          shadow_size = 10;
        }
      ];

      image = [
        # Profile photo
        {
          path = lockScreenProfilePicturePath;
          border_color = "rgba(216, 222, 233, 0.70)";
          border_size = 3;
          size = 220;
          rounding = -1;
          rotate = 0;
          reload_time = -1;
          position = "0, 15";
          halign = "center";
          valign = "center";
        }

        # Turn off monitor image
        {
          border_size = 0;
          path = lockScreenTurnOffMonitorPicturePath;
          halign = "center";
          valign = "center";
          position = "0, -600";
          size = 100;
          reload_time = -1;
          rotate = 0;
          rounding = 0;
        }
      ];

      shape = {
        color = "rgba(100, 114, 125, 0.8)";
        size = "120, 120";
        rounding = 20;
        position = "0, -600";
        halign = "center";
        valign = "center";
        zindex = 0;
        onclick = "hyprctl dispatch dpms off";
      };

    };
  };
}
