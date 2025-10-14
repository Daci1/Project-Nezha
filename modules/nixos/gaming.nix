{ pkgs, ...}:

{
  programs.gpu-screen-recorder.enable = true;
  programs.steam.enable = true;
  programs.steam.gamescopeSession.enable = true;
  environment.systemPackages = with pkgs; [
	mangohud
	gpu-screen-recorder-gtk
  ];

  programs.gamemode.enable = true;
}
