{ pkgs, lib, ... }:

{
  wayland.windowManager.hyprland = {
    settings = {
      # Some default env vars.
      env = [
        "XCURSOR_SIZE,24"
        "XCURSOR_THEME, Bibata-Modern-Classic"
        "QT_QPA_PLATFORMTHEME,qt6ct" # change to qt6ct if you have that
        "DOCKER_HOST,unix:///var/run/docker.sock"
      ];
    };
  };
}
