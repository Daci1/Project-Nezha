{ pkgs, ... }:

{
  services.sunshine = {
    enable = false;
    autoStart = false;
    capSysAdmin = true;
    openFirewall = true;
    applications = {
      env = {
        PATH = "$(PATH):$(HOME)/.local/bin";
      };
      apps = [
        {
          name = "Desktop";
          "image-path" = "desktop.png";
        }
        {
          name = "Virtual Hyprland";
          "image-path" = "desktop.png";
          prep-cmd = [
            {
              do = "sh -c \"hyprctl keyword monitor Virtual-1,\${SUNSHINE_CLIENT_WIDTH}x\${SUNSHINE_CLIENT_HEIGHT}@\${SUNSHINE_CLIENT_FPS},auto,2; hyprctl keyword monitor DP-3,disable\"";
              undo = "sh -c \"hyprctl keyword monitor Virtual-1,disable; hyprctl keyword monitor DP-3,3440x1440@165, 0x0, 1.25, bitdepth,8, vrr, 3;  hyprctl reload\"";
            }
          ];
        }
      ];
    };

  };
}
