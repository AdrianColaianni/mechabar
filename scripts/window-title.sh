#!/usr/bin/env bash
# Focused-window title for waybar via mango IPC.
# mango 0.15 dropped the dwl-ipc protocol, so waybar's dwl/window module
# no longer works; this streams the same info from `mmsg`.

exec mmsg watch focusing-client 2>/dev/null | jq -c --unbuffered '
	(.title // "") as $t |
	($t
		| if false then .
		  elif test(" - Brave$") then "\udb81\udd9f " + sub(" - Brave$"; "") + ""
		  elif test(" - Nvim$") then "\ue7c5 " + sub(" - Nvim$"; "") + ""
		  elif test(" - zsh$") then "\uf120 [" + sub(" - zsh$"; "") + "]"
		  elif test(" — Evolution$") then "\uf42f  " + sub(" — Evolution$"; "") + ""
		  else . end) as $r |
	{text: $r, tooltip: $t}
'
