{ pkgs, ... }:

{
	environment.systemPackages = with pkgs; [
	  lazydocker
    lazygit
	];
}


