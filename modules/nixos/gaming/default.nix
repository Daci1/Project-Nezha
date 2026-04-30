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
  ];
}
