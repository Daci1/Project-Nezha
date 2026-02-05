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
}
