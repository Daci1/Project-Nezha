{ pkgs, lib, ... }:

{
	programs.cava = {
	  enable = true;
	  package = pkgs.cava;
	};
}



