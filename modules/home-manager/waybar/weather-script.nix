{ pkgs }:

pkgs.writeShellScriptBin "weather" ''
  LOC="$1"
  LOCATION=$(sed -e "s/ /%20/g" <<<"$LOC")

  content=$(${pkgs.curl}/bin/curl -sS "https://thisdavej.azurewebsites.net/api/weather/current?loc=$LOCATION&deg=C")
  ICON=$(${pkgs.curl}/bin/curl -s "https://wttr.in/$1?format=1" | ${pkgs.gnused}/bin/sed 's/[+0-9a-cA-Z°-]//g')

  TEMP=$(echo "$content" | ${pkgs.jq}/bin/jq -r '. | "\(.temperature)°\(.degType)"' | ${pkgs.gnused}/bin/sed 's/"//g')
  TOOLTIP=$(echo "$content" | ${pkgs.jq}/bin/jq -r '. | "\(.temperature)°\(.degType)\n\(.skytext)"' | ${pkgs.gnused}/bin/sed 's/"//g')
  CLASS=$(echo "$content" | ${pkgs.jq}/bin/jq .skytext)

  echo '{"text": "'$TEMP'", "tooltip": "'$ICON $TOOLTIP $LOC'", "class": '$CLASS' }'
''

