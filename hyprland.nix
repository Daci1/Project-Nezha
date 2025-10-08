{ config, pkgs, ... }:

{
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;  # enable XWayland support (recommended)
  };

  environment.systemPackages = with pkgs; [
    waybar           # status bar
    rofi             # app launcher
    kitty            # nice terminal
    wlogout          # logout/power menu
  ];
}
