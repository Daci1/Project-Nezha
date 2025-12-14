{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ docker-compose ];
  virtualisation.docker = {
    enable = true;
  };
  # Optional, can run docker without sudo
  users.users.daci.extraGroups = [ "docker" ];
}
