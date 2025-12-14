{ pkgs, lib, ... }:

{
  wayland.windowManager.hyprland = {
    settings = {
      # workspace monitors
      workspace = [
        "1, monitor:DP-3"
        "2, monitor:DP-3"
        "3, monitor:DP-3"
        "4, monitor:DP-3"
        "5, monitor:DP-3"

        # workspace on-created-empty rules
        "2, on-created-empty:firefox"
        "3, on-created-empty:exec flatpak run com.discordapp.Discord"
        "4, on-created-empty:exec env GDK_SCALE=1.25 GDK_DPI_SCALE=1.25 steam"
        "5, on-created-empty:exec kitty sh -c 'lazydocker'"
      ];
    };
  };
}
