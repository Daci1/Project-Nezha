{ pkgs, stablePkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    rocmPackages.rocminfo
    rocmPackages.rocm-smi
    rocmPackages.rocm-core
    btop-rocm

    stablePkgs.ollama-rocm
    librechat
  ];

  services.open-webui = {
    enable = false;
    port = 9000;
  };

  services.searx = {
    enable = false;
    redisCreateLocally = true;
    settings = {
      server.port = 9001;
      server.bind_address = "0.0.0.0";
      server.secret_key = "f4081680-8fa6-4a9c-80a8-e5bc37b64856";
      engines = [
        { name = "duckduckgo"; }
        { name = "brave"; }
        { name = "wikipedia"; }
      ];

      search = {
        safe_search = 0;
        formats = [
          "html"
          "json"
        ];
      };

      outgoing = {
        request_timeout = 1;
      };
    };
  };

  services.ollama = {
    enable = false;
    package = stablePkgs.ollama-rocm;
    models = "/var/lib/ollama/models";
    loadModels = [
      "qwen2.5-coder:14b"
    ];
    syncModels = true;
    host = "[::]";
    openFirewall = true;
  };
}
