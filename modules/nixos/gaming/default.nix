{ pkgs, ... }:

{
  imports = [
    ./steam.nix
    ./minecraft.nix
  ];

  environment.systemPackages = with pkgs; [
    faugus-launcher
    goverlay
  ];
}
