{ pkgs, inputs, stablePkgs, ...}:

{
	environment.systemPackages = with stablePkgs; [
	  jetbrains.jdk
	  jetbrains.goland
	] ++ (with pkgs; [
	  pkgs.go
	]);
}

