{ pkgs, lib, ... }:

let
  weatherScript = import ./weather-script.nix { inherit pkgs; };
  toggleBluetoothScript = import ./toggleBluetooth-script.nix { inherit pkgs; };
  greenColor = "#37f499";
  redColor = "#ef2d56";
  orangeColor = "#e58f2a";
in
{
  home.packages = with pkgs; [
    nmgui
  ];

  programs.waybar = {
    enable = true;
    package = pkgs.waybar;
    settings = {
      mainBar = {
        "layer" = "top";
        "position" = "top";
        "margin" = "5";

        "height" = 30;

        "modules-left" = [
          "group/currentOsWithWorkspaces"
          "custom/media"
        ];

        "modules-center" = [
          "clock"
        ];

        "modules-right" = [
          "tray"
          "custom/weather"
          "memory"
          "cpu"
          "pulseaudio"
          "pulseaudio#microphone"
          "group/connections"
          "custom/power"
        ];

        "group/connections" = {
          "orientation" = "inherit";
          "modules" = [
            "bluetooth"
            "network"
          ];
        };

        "group/currentOsWithWorkspaces" = {
          "orientation" = "inherit";
          "modules" = [
            "custom/os-logo"
            "custom/separator"
            "hyprland/workspaces"
          ];
        };

        # Modules

        "idle_inhibitor" = {
          "format" = "{icon} ";
          "format-icons" = {
            "activated" = "";
            "deactivated" = "";
          };
        };

        "battery" = {
          "states" = {
            # "good": 95,
            "warning" = 30;
            "critical" = 15;
          };
          "format" = "{capacity}% {icon} ";
          "format-charging" = "{capacity}% 󰂄";
          "format-plugged" = "{capacity}% ";
          "format-icons" = [
            ""
            ""
            ""
            ""
            ""
          ];
        };

        "clock" = {
          "interval" = 10;
          "format" = "  {:%e %b %Y %H:%M} ";
          "tooltip-format" = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
          "actions" = {
            "on-click-right" = "mode";
            "on-scroll-up" = [
              "tz_up"
              "shift_up"
            ];
            "on-scroll-down" = [
              "tz_down"
              "shift_down"
            ];
          };
        };

        "cpu" = {
          "interval" = 5;
          "format" = "  {usage}% ({load})"; # Icon: microchip
          "states" = {
            "warning" = 70;
            "critical" = 90;
          };
        };

        "memory" = {
          "interval" = 5;
          "format" = "  {}%"; # Icon: memory",
          "states" = {
            "warning" = 70;
            "critical" = 90;
          };
        };

        "network" = {
          "interval" = 5;
          "format-wifi" = " "; # Icon: wifi
          "format-ethernet" = " "; # Icon: ethernet
          "format-disconnected" = "⚠  Disconnected";
          "tooltip-format" = "{ifname}: {ipaddr}";
          "on-click-right" = "${pkgs.nmgui}/bin/nmgui";
        };

        "network#vpn" = {
          "interface" = "tun0";
          "format" = " ";
          "format-disconnected" = "⚠  Disconnected";
          "tooltip-format" = "{ifname}: {ipaddr}/{cidr}";
        };

        "hyprland/mode" = {
          "format" = "{}";
          "tooltip" = false;
        };

        "hyprland/window" = {
          "format" = "{}";
          "max-length" = 120;
        };

        "hyprland/workspaces" = {
          "disable-scroll" = true;
          "disable-markup" = false;
          "all-outputs" = true;
          "format" = " {icon}  ";
          "format-icons" = {
            "1" = "";
            "2" = "";
            "3" = "";
            "4" = "";
            "5" = "󰡨";
            "6" = "󰍳";
          };
          "persistent-workspaces" = {
            "*" = [
              1
              2
              3
            ];
          };
        };

        "pulseaudio" = {
          "scroll-step" = 1; # %, can be a float
          "format" = "{icon} {volume}%";
          "format-bluetooth" = "{volume}% {icon}  {format_source}";
          "format-bluetooth-muted" = " {icon}  {format_source}";
          "format-muted" = "󰸈 {icon} {volume}%";
          "format-icons" = {
            "discord-share" = "";
            "headphone" = "";
            "hands-free" = "וֹ";
            "headset" = "";
            "phone" = "";
            "portable" = "";
            "car" = "";
            "default" = [ "" ];
          };
          "on-click" = "/home/daci/hypr-dots/hypr/hyprland/scripts/muteVolume.sh";
          "on-click-right" = "pavucontrol";
          "on-scroll-up" = "pactl set-sink-volume @DEFAULT_SINK@ +5%";
          "on-scroll-down" = "pactl set-sink-volume @DEFAULT_SINK@ -5%";
        };

        "bluetooth" = {
          "format" = " {status} |";
          "on-click" = "${toggleBluetoothScript}/bin/toggleBluetooth";
          "on-click-right" = "blueman-manager";
        };

        "pulseaudio#microphone" = {
          "format" = "{format_source}";
          "format-source" = " {volume}%";
          "format-source-muted" = "  {volume}%";
          "on-click-right" = "pavucontrol";
          "scroll-step" = 5;
        };

        # to use the weather module replace <your_location> with your city or town
        # note: do not use spaces: new york would be newyork
        "custom/weather" = {
          "exec" = "${weatherScript}/bin/weather Timisoara";
          "return-type" = "json";
          "interval" = 600;
        };

        "custom/os-logo" = {
          "format" = " ";
          "tooltip" = false;
          "on-click" = "hyprsysteminfo";
        };

        "custom/separator" = {
          "format" = "|";
          "interval" = "once";
          "tooltip" = false;
        };

        "tray" = {
          "icon-size" = 18;
          "spacing" = 10;
        };

        "backlight#icon" = {
          "format" = "{icon}";
          "format-icons" = [ "" ];
          "on-scroll-down" = "brightnessctl -c backlight set 1%-";
          "on-scroll-up" = "brightnessctl -c backlight set +1%";
        };

        "backlight#value" = {
          "format" = "{percent}%";
          "on-scroll-down" = "brightnessctl -c backlight set 1%-";
          "on-scroll-up" = "brightnessctl -c backlight set +1%";
        };

        "custom/firefox" = {
          "format" = " ";
          "on-click" = "exec firefox";
          "tooltip" = false;
        };

        "custom/terminal" = {
          "format" = " ";
          "on-click" = "exec kitty";
          "tooltip" = false;
        };

        "custom/files" = {
          "format" = " ";
          "on-click" = "exec nautilus";
          "tooltip" = false;
        };

        "custom/launcher" = {
          "format" = " ";
          "on-click" = "exec wofi -c ~/.config/wofi/config -I";
          "tooltip" = false;
        };

        "custom/power" = {
          "format" = "⏻";
          "on-click" = "exec wlogout";
          "tooltip" = false;
        };

        "custom/wl-gammarelay-temperature" = {
          "format" = "{} ";
          "exec" = "wl-gammarelay-rs watch {t}";
          "on-scroll-up" =
            "busctl --user -- call rs.wl-gammarelay / rs.wl.gammarelay UpdateTemperature n +200";
          "on-scroll-down" =
            "busctl --user -- call rs.wl-gammarelay / rs.wl.gammarelay UpdateTemperature n -200";
          "on-click" = "busctl --user set-property rs.wl-gammarelay / rs.wl.gammarelay Temperature q 6500";
        };
      };
    };

    style = ''
      @define-color default #66ACED;

      @keyframes blink-warning {
          70% {
              color: white;
          }

          to {
              color: white;
              background-color: orange;
          }
      }

      @keyframes blink-critical {
          70% {
            color: white;
          }

          to {
              color: white;
              background-color: red;
          }
      }

      /* -----------------------------------------------------------------------------
       * Base styles
       * -------------------------------------------------------------------------- */

      /* Reset all styles */
      * {
          border: none;
          border-radius: 0;
          min-height: 0;
          margin: 1px;
          padding: 0;
      }


      /* The whole bar */
      window#waybar {
          background-color: rgba(0,0,0,0);
          font-family: JetBrainsMono Nerd Font;
          font-size: 15px;
      }

      /* Every modules */
      #battery,
      #clock,
      #backlight,
      #cpu,
      #custom-keyboard-layout,
      #memory,
      #mode,
      #custom-weather,
      #connections,
      #pulseaudio,
      #temperature,
      #tray,
      #idle_inhibitor,
      #window,
      #custom-power,
      #custom-media,
      #custom-PBPbattery,
      #currentOsWithWorkspaces,
      #custom-wl-gammarelay-temperature {
          padding:0.25rem 0.75rem;
          margin: 1px 6px;
          background-color: rgba(0,0,0,0.8);
          border-radius: 10px;
          color: @default;
      }

      /* -----------------------------------------------------------------------------
       * Modules styles
       * -------------------------------------------------------------------------- */

      #clock {
          color: ${greenColor};
      }

      #custom-weather {
          color: #FF4499;
      }

      #battery {
          animation-timing-function: linear;
          animation-iteration-count: infinite;
          animation-direction: alternate;
      }

      #battery.warning {
          color: orange;
      }

      #battery.critical {
          color: red;
      }

      #battery.warning.discharging {
          animation-name: blink-warning;
          animation-duration: 3s;
      }

      #battery.critical.discharging {
          animation-name: blink-critical;
          animation-duration: 2s;
      }

      #cpu {
          color: ${orangeColor};
      }

      #cpu.warning {
          color: ${orangeColor};
      }

      #cpu.critical {
          color: ${redColor};
      }

      #memory {
          animation-timing-function: linear;
          animation-iteration-count: infinite;
          animation-direction: alternate;
          color: ${orangeColor};
      }

      #memory.warning {
          color: orange;
       }

      #memory.critical {
          color: red;
          animation-name: blink-critical;
          animation-duration: 2s;
          padding-left:5px;
          padding-right:5px;
      }

      #mode {
          border-bottom: 3px transparent;
          color:#ff4499;
          margin-left: 5px;
          padding: 7px;
      }

      #network.disconnected {
          color: orange;
      }

      #pulseaudio {
          color: #987afb;
          border-left: 0px;
          border-right: 0px;
          margin-right: 0;
          border-radius: 10px 0 0 10px;
      }

      #pulseaudio.microphone {
          border-left: 0px;
          border-right: 0px;
          margin-left: 0;
          padding-left: 0;
          border-radius: 0 10px 10px 0;
      }


      #temperature.critical {
          color: red;
      }

      #window {
          font-weight: bold;
          color: #f7768e;
      }

      #custom-media {
          color: #bb9af7;
      }

      #workspaces {
          font-size:20px;
          border-radius: 10px;
      }

      #workspaces button {
          border-bottom: 3px solid transparent;
          margin-bottom: 0px;
          color: #987afb;
      }

      /* Removes unwanted on hover background color on workspaces */
      #workspaces button:hover {
          box-shadow: none; /* Remove predefined box-shadow */
          text-shadow: none; /* Remove predefined text-shadow */
          background: none; /* Remove predefined background color (white) */
          transition: none; /* Disable predefined animations */
      }

      #workspaces button.active {
          border-bottom: 1px solid #987afb;
          margin-bottom: 1px;
          padding-left:0;
      }

      #workspaces button.urgent {
          border-color: #c9545d;
          color: #c9545d;
      }

      #custom-power {
          font-size:18px;
          padding-right: 17px;
          padding-left: 13px;
      }

      #custom-launcher {
          font-size:16px;
          margin-left:15px;
          margin-right:10px;
      }

      #backlight.icon {
          padding-right:1px;
          font-size: 13px;
      }

      #custom-wl-gammarelay-temperature {
          color: #f7768e;
      }

      #connections #bluetooth {
      	padding-right: 10px;
      	color: @default;
      }

      #custom-os-logo {
          font-size: 20px;
          padding-left: 10px;
      }

      #custom-separator {
        font-size: 22px;
        border-right: 2px;
        color: gray;
      }

      tooltip {
          background-color: rgba(0, 0, 0, 0.8);
      }
      	  '';
  };
}
