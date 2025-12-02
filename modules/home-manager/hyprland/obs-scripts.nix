{ pkgs }:
pkgs.symlinkJoin {
  name = "obs-replay-scripts";
  paths = [
    (pkgs.writeShellScriptBin "obs-replay-toggle" ''
      output=$(obs-cmd replay toggle 2>&1)
      status=$?
      if [ $status -ne 0 ]; then
        notify-send -t 2000 "Instant Replay" "Failed to toggle Instant Replay!" -u critical
        exit 1
      fi
      if echo "$output" | grep -q "Result: true"; then
        notify-send -t 2000 "Instant Replay started"
      elif echo "$output" | grep -q "Result: false"; then
        notify-send -t 2000 "Instant Replay stopped"
      else
        notify-send -t 2000 "Instant Replay" "Unknown response from OBS!" -u critical
      fi
    '')
    (pkgs.writeShellScriptBin "obs-replay-save" ''
      output=$(obs-cmd replay save 2>&1)
      if echo "$output" | grep -q "Result: Ok(())"; then
        notify-send -t 2000 "Replay Saved successfully."
      elif echo "$output" | grep -q "Result: Err(Api { code: OutputNotRunning"; then
        notify-send -t 2000 "Replay Save" "No replay buffer running!" -u critical
      else
        notify-send -t 2000 "Replay Save" "Unknown response from OBS!" -u critical
      fi
    '')
  ];
}
