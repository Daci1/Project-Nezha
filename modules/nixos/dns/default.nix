{ ... }:

{
  services.duckdns = {
    enable = true;
    domains = [ "daci-jellyfin" ];
    tokenFile = ./token;
  };
}
