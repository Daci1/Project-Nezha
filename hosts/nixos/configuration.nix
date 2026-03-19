{
  config,
  pkgs,
  inputs,
  stablePkgs,
  ...
}:

let
  blender443 =
    import
      (fetchTarball {
        url = "https://github.com/NixOS/nixpkgs/archive/1d4c88323ac36805d09657d13a5273aea1b34f0c.tar.gz";
        sha256 = "1061lm95hbmpqcbbkr493ypkwy3rs4wgxv21wfj4wg005lwn3i3s";
      })
      {
        system = pkgs.system;
      };
in
{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.default
    ../../modules/nixos/bluetooth.nix
    ../../modules/nixos/development
    ../../modules/nixos/dns
    ../../modules/nixos/file-explorer.nix
    ../../modules/nixos/gaming
    ../../modules/nixos/greetd.nix
    ../../modules/nixos/llm.nix
    ../../modules/nixos/multimedia.nix
    ../../modules/nixos/obs.nix
    ../../modules/nixos/sensors.nix
    ../../modules/nixos/xdg-portal-defaults.nix
  ];

  # Nix Settings
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Linux Kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;

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

  services.desktopManager.plasma6.enable = true;

  services.xserver.xkb = {
    layout = "us";
    variant = "";
    options = "caps:super";
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
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    shell = pkgs.zsh;
  };

  home-manager = {
    extraSpecialArgs = { inherit inputs stablePkgs; };
    useUserPackages = true;
    useGlobalPkgs = true;
    backupFileExtension = "backup";
    users = {
      "daci" = import ./home.nix;
    };
  };

  # ALlow unfree
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    efibootmgr
    os-prober
    git
    vulkan-tools
    tree
    bibata-cursors
    pavucontrol
    pulseaudio
    zip
    unzip
    qbittorrent-enhanced
    upscayl
    gimp
    qimgv
    blender443.blender
    slack
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

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [
      80
      7777
      25565
      9001
    ];
  };

  qt = {
    enable = true;
    platformTheme = "qt5ct";
    style = "kvantum";
  };

}
