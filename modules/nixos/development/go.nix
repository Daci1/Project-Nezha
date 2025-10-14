{ pkgs, inputs, stablePkgs, ...}:

{
	environment.systemPackages = with stablePkgs; [
	  jetbrains.jdk
	  jetbrains.goland
          go
	] ++ (with pkgs; []);
}

