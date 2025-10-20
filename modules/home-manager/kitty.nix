{ pkgs, ... }:

{
  programs.kitty = {
    enable = true;
    package = pkgs.kitty;
    settings = {
      # Base colors
      background = "#0D1116";
      foreground = "#ffffff";

      # Cursor
      cursor = "#ffffff";

      # Selection highlight
      selection_background = "#e9b3fd";
      selection_foreground = "#ffffff";

      # Black
      color0 = "#0D1116";
      color8 = "#e58f2a";

      # Red
      color1 = "#ef2d56";
      color9 = "#ef2d56";

      # Green
      color2 = "#37f499";
      color10 = "#37f499";

      # Yellow
      color3 = "#9ad900";
      color11 = "#9ad900";

      # Blue
      color4 = "#987afb";
      color12 = "#987afb";

      # Magenta
      color5 = "#fca6ff";
      color13 = "#fca6ff";

      # Cyan
      color6 = "#04d1f9";
      color14 = "#04d1f9";

      # White
      color7 = "#ffffff";
      color15 = "#ffffff";

      # URL color
      url_color = "#04d1f9";

      # Other config
      confirm_os_window_close = 0;
    };
  };
}
