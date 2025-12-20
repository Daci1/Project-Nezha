{...}:

{
  services.greetd = {
    enable = true;
    settings = rec {
      initial_session = {
        command = "hyprland > /dev/null 2>&1";
        user = "daci";
      };
      default_session = initial_session;
    };
  };
}
