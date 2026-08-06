{ pkgs, ... }:

{
  home.packages = with pkgs; [
    protonup-ng
    protonplus
    heroic
  ];

  home.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/steam/compatibilitytools.d";
  };

  xdg.desktopEntries.exiled-exchange-2 = {
    name = "Exiled Exchange 2";
    exec = "${pkgs.appimage-run}/bin/appimage-run /home/daci/Downloads/Exiled-Exchange-2-0.15.4.AppImage";
    terminal = false;
    type = "Application";
    categories = [ "Game" "Utility" ];
  };
}
