{ pkgs, ... }:

{
	imports = [
	  ./database.nix
	  ./docker.nix
	  ./jetbrains.nix
	];

	programs.direnv = {
	  enable = true;
	  enableZshIntegration = true;
	  nix-direnv = {
	    enable = true;
	  };
	};
	
	environment.systemPackages = with pkgs; [
	  postman
	];
}


