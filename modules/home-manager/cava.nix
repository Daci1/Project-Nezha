{ pkgs, lib, ... }:

{
	programs.cava = {
	  enable = true;
	  package = pkgs.cava;
	  settings = {
		  general = {
		    autosens = 1;
		    sensitivity = 100;
		  };
		  input = {
			  method = "pulse";
			  source = "auto";
		  };
		  output = { };
		  color = {
			  gradient = 1;
			  gradient_count = 8;
			  gradient_color_1 = "'#000000'";
			  gradient_color_2 = "'#ef2d56'";
			  gradient_color_3 = "'#2ecc71'";
			  gradient_color_4 = "'#f0fa8b'";
			  gradient_color_5 = "'#7d5fff'";
			  gradient_color_6 = "'#ff78c5'";
			  gradient_color_7 = "'#7d5fff'";
			  gradient_color_8 = "'#bbbbbb'";
		  };
		  smoothing = { };
		  eq = { };
	  };
	};
}



