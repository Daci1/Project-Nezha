{ pkgs, ... }:

{
	imports = [
	  ./go.nix
	  ./docker.nix
	];

	programs.direnv = {
	  enable = true;
	  enableZshIntegration = true;
	  nix-direnv = {
	    enable = true;
	  };
	};
}


