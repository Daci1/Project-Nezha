{ pkgs, ... }:

{
  imports = [
    ./steam.nix
    ./minecraft.nix
    ./sunshine.nix
  ];

  environment.systemPackages = with pkgs; [
    faugus-launcher
    goverlay
    appimage-run
    clamav # anti virus checker
  ];
  services.clamav = {
    updater.enable = true;
    daemon.enable = true;
  };

}
