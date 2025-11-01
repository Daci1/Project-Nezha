{ pkgs, ... }:

{
	environment.systemPackages = with pkgs; [
	  bluez
	  bluez-tools
	];
	hardware.bluetooth.enable = true;
	services.blueman.enable = true;
}
