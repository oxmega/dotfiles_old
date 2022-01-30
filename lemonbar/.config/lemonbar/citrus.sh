#!/usr/bin/env bash
# A very minimal and basic bar. Battery state indicated by icons and current
# charge. Volume and mute state indicated by icons. RAM usage, date and VPN
# status.
# Fonts required:  Cherry BDF and Siji BDF
# https://github.com/turquoise-hexagon/cherry
# https://github.com/stark/siji
#
# OX![ox@raisedfist.net][github.com/acannibalox]
if pgrep -cx lemonbar ; then
  pkill -ox -9 lemonbar
fi

# fonts and colours.
PRIMARYFONT='SF\ Mono:size=11'
SECONDARYFONT='Siji:size=14'
FC='%{%F-}'
FC1='%{F#f0ae00}'
FC2='%{F#f4ecdb}'
#BC='%{B-}'
#BC1='%{B#051f42}'
#BC2='%{B#af5f5f}'
#BC3='%{B#212121}'

volume() {
  VOL=$(pamixer --get-volume)
  GETMUTE=$(pamixer --get-mute)

  if [ "$VOL" = '0' ] || [ "$GETMUTE" = "true" ]; then
    printf '%b%s' "$FC1\ue052$FC" "$FC2muted$FC"
 	else
 	  printf '%b%s' "$FC1\ue050$FC" "$FC2$VOL$FC"
  fi

}

memory() {
  ram=$(free -h | awk 'NR==2{printf "%s/%s (%.2f%%)\n",$3,$2,$3/$2 }')
  printf '%b%s' "$FC1\ue021$FC" "$FC2$ram$FC"
}

clock() {
	#date "+%l:%M %a %d %b"
  date=$(date "+(%I:%M) %a %d %m/%Y")
  printf '%b%s' "$FC1\ue262$FC" "$FC2$date.$FC"
}

battery() {
  pcharge=$(acpi | cut -d , -f 2 |  sed 's/ //g')
	bstate=$(grep -E 'Full|Charging|Unknown|Discharging' \
	/sys/class/power_supply/BAT0/status)

typeset -gA icon
	icon=([Full]="\ue201"
				[Charging]="\ue041"
				[Discharging]="\ue213"
				)

				printf '%b' "$FC1${icon[$bstate]}$FC$FC2$pcharge$FC"
}

vpn() {

  tmpvpn="$HOME/.local/run/openvpn.pid"

  if [ -e "$tmpvpn" ]; then
    printf '%b' "$FC1 VPN: ON $FC"
  else
    printf '%b' "$FC1 VPN: OFF $FC"
  fi

}


GEO="1920x30+0+0"

while true; do
  echo "%{c}  $(battery) $(volume) $(memory) $(clock) $(vpn)%{B-}  %{c-}"
  sleep 1;
done | lemonbar -p -d -g "$GEO" -o 5\
    -f "$PRIMARYFONT" -f "$SECONDARYFONT" "$PRI_MON"
