{ pkgs, lib, ... }:

let
  hyprctl = "${pkgs.hyprland}/bin/hyprctl";

  steam-game-mover = pkgs.writers.writeJSBin "steam-game-mover" { } ''
    const net = require("net");
    const fs = require("fs");
    const { execFileSync } = require("child_process");

    const HYPRCTL = "${hyprctl}";
    const SOCKET2 = process.env.XDG_RUNTIME_DIR
      + "/hypr/" + process.env.HYPRLAND_INSTANCE_SIGNATURE
      + "/.socket2.sock";
    const SKIP = new Set(["steam", "Steam"]);

    function hasSteamAncestor(pid) {
      while (pid > 1) {
        try {
          const comm = fs.readFileSync("/proc/" + pid + "/comm", "utf8").trim();
          if (comm === "steam") return true;
          const stat = fs.readFileSync("/proc/" + pid + "/stat", "utf8");
          pid = parseInt(stat.split(") ")[1].split(" ")[1], 10); // parent PID
        } catch {
          return false;
        }
      }
      return false;
    }

    const sock = net.createConnection(SOCKET2);
    let buf = "";

    sock.on("data", (chunk) => {
      buf += chunk.toString();
      let idx;
      while ((idx = buf.indexOf("\n")) !== -1) {
        const line = buf.slice(0, idx);
        buf = buf.slice(idx + 1);

        if (!line.startsWith("openwindow>>")) continue;
        const parts = line.slice("openwindow>>".length).split(",", 4);
        const addr = parts[0];
        const cls = parts[2];

        if (cls.startsWith("steam_app_") || SKIP.has(cls)) continue;

        setTimeout(() => {
          try {
            const out = execFileSync(HYPRCTL, ["clients", "-j"], { encoding: "utf8" });
            const clients = JSON.parse(out);
            const client = clients.find((c) => c.address === "0x" + addr);
            if (!client || client.pid < 1) return;
            if (hasSteamAncestor(client.pid)) {
              execFileSync(HYPRCTL, ["dispatch", "movetoworkspace", "1,address:0x" + addr]);
            }
          } catch {}
        }, 300);
      }
    });
  '';
in

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
          name = "Zen Rules";
          workspace = 2;
          match = {
            class = "^(zen-twilight)$";
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
            title = "negative:^Steam$";
          };
        }

        {
          name = "Steam Friends List";
          float = true;
          size = "392 748";
          move = "2305 317";
          match = {
            class = "^(steam)$";
            title = "^Friends List$";
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
          name = "Thunar Rename Popup";
          float = true;
          center = true;
          match = {
            class = "^(thunar)$";
            title = "^Rename .*$";
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
          name = "Picture in Picture Zen";
          float = true;
          pin = true;
          move = "2206 78";
          size = "500 280";
          match = {
            class = "^(zen-twilight)$";
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

  systemd.user.services.steam-game-mover = {
    Unit = {
      Description = "Move Steam native game windows to workspace 1";
      After = [ "graphical-session.target" ];
    };
    Service = {
      ExecStart = "${steam-game-mover}/bin/steam-game-mover";
      Restart = "always";
      RestartSec = 3;
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
}
