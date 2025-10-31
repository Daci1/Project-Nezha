{ pkgs, ...}:

{
	imports = [ 
		./steam.nix 
		./minecraft.nix 
	];

	programs.gpu-screen-recorder.enable = true;
}

