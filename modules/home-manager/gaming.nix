{ pkgs, ... }:

{
	home.packages = with pkgs; [
	  protonup
	];

	home.sessionVariables = {
	  STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/steam/compatibilitytools.d";
	};
}
