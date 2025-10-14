{ config, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      inputs.home-manager.nixosModules.default
      ../../modules/nixos/gaming.nix
      ../../modules/nixos/file-explorer.nix
      ../../modules/nixos/multimedia.nix
      ../../modules/nixos/development
    ];

  # Nix Settings
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Bootloader.
  boot.loader = {
	  efi.canTouchEfiVariables = true;
	  timeout = 10;
	  grub = {
		  enable = true;
		  devices = [ "nodev" ];
		  efiSupport = true;
		  useOSProber = true;
		  default = "saved";
	  };
  };

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Bucharest";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "ro_RO.UTF-8";
    LC_IDENTIFICATION = "ro_RO.UTF-8";
    LC_MEASUREMENT = "ro_RO.UTF-8";
    LC_MONETARY = "ro_RO.UTF-8";
    LC_NAME = "ro_RO.UTF-8";
    LC_NUMERIC = "ro_RO.UTF-8";
    LC_PAPER = "ro_RO.UTF-8";
    LC_TELEPHONE = "ro_RO.UTF-8";
    LC_TIME = "ro_RO.UTF-8";
  };

  services.xserver.enable = true;

  services.displayManager.sddm = {
	enable = true;
	extraPackages = with pkgs; [
		kdePackages.qtsvg
		kdePackages.qtvirtualkeyboard
		kdePackages.qtmultimedia
	];
	theme = "sddm-astronaut-theme";
  };
  services.desktopManager.plasma6.enable = true;

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  services.printing.enable = true;

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };


  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.daci = {
    isNormalUser = true;
    description = "Daci";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
  };
  
  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    useUserPackages = true;
    useGlobalPkgs = true;
    backupFileExtension = "backup";
    users = {
	"daci" = import ./home.nix;	
    };
  };

  programs.firefox.enable = true;

  # ALlow unfree
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
	vim
	efibootmgr
	os-prober
	git
	vulkan-tools
	solaar
	(sddm-astronaut.override {
	  embeddedTheme = "jake_the_dog";
	})
	tree
    	kdePackages.xdg-desktop-portal-kde
	obs-studio
	bibata-cursors
	pavucontrol
	pulseaudio
	zip
	unzip
  #  wget
  ];

  # List services that you want to enable:
  services.flatpak.enable = true;
  systemd.services.flatpak-repo = {
    wantedBy = [ "multi-user.target" ];
    path = [ pkgs.flatpak ];
    script = ''
	flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
    '';
  };

  programs.hyprland.enable = true;

  programs.zsh.enable = true;
  xdg.portal = {
	enable = true;
	extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };
  
  fonts = {
    packages = with pkgs; [
	nerd-fonts.jetbrains-mono
    ];
  };

  system.stateVersion = "25.05";

}
