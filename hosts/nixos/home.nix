{ config, pkgs, stablePkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  imports = [
    ../../modules/home-manager/cava.nix
    ../../modules/home-manager/gaming.nix
    ../../modules/home-manager/hyprland/hyprland.nix
    ../../modules/home-manager/nvim
    ../../modules/home-manager/zsh/zsh.nix
  ];

  home.username = "daci";
  home.homeDirectory = "/home/daci";

  home.stateVersion = "25.05"; # Please read the comment before changing.

  home.packages = with pkgs; [
	lazydocker
	playerctl
  ];

  home.file = {
  };

  home.sessionVariables = {
    EDITOR = "vim";
    NIXOS_OZONE_WL = "1";
    #GTK_THEME = "TokyoNight-Dark";
  };
 
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  qt = {
	enable = true;
	platformTheme.name = "qtct";
	style.name = "kvantum";
  };

  gtk = {
	  enable = true;
	  theme = {
		name = "Dracula";
		package = pkgs.dracula-theme;
	  };
	  iconTheme = {
		name = "Dracula";
		package = pkgs.dracula-icon-theme;
		
	  };
	  cursorTheme = {
		  name = "Bibata-Modern-Classic";
		  package = pkgs.bibata-cursors;
		  size = 24;
	  };
	  gtk3 = {
		  extraConfig.gtk-application-prefer-dark-theme = true;
	  };
  };

  dconf.settings = {
	  "org/gnome/desktop/interface" = {
		  gtk-theme = "Dracula";
		  color-scheme = "prefer-dark";
	  };
  };

  home.pointerCursor = {
         gtk.enable = true;
         package = pkgs.bibata-cursors;
         name = "Bibata-Modern-Classic";
         size = 24;
  };
  
  home.file.".local/share/flatpak/overrides/global".text = ''
	  [Context]
	  filesystems=/nix/store:ro;
  '';
}
