{ pkgs }:

pkgs.writeShellScriptBin "toggleBluetooth" ''
  #!/usr/bin/env bash

  # Check current power status
  power_status=$(${pkgs.bluez}/bin/bluetoothctl show | awk '/Powered/ {print $2}')

  if [ "$power_status" == "yes" ]; then
      ${pkgs.bluez}/bin/bluetoothctl power off
  else
      ${pkgs.bluez}/bin/bluetoothctl power on
  fi
''
