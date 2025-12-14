{ ... }:

{
  services.duckdns = {
    enable = true;
    domains = [ "daci-bmc" ];
    tokenFile = ./token;
  };
}
