{ pkgs , ... }:

{
  # Still have to manually enable websockets in OBS settings
  programs.obs-studio = {
    enable =  true;
  };

  environment.systemPackages = with pkgs; [
    obs-cmd
  ];
}
