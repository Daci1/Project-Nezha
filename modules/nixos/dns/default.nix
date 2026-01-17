{ ... }:

{
  services.duckdns = {
    enable = false;
    domains = [ "daci-bmc" ];
    tokenFile = ./token;
  };
}
