{...}:

{
  services.greetd = {
    enable = true;
    settings = rec {
      initial_session = {
        command = "start-hyprland";
        user = "daci";
      };
      default_session = initial_session;
    };
  };
}
