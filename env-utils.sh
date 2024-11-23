_gum=${_gum:-@gum@}
_gum=${_gum//@/}

fxbox() {
	local args=("$@")
	$_gum style --border double --margin "1 2" --padding "1 4" "${args[@]}"
}

fxspin() {
	local title=$1
	shift

	if [[ "$FLOX_ENVS_TESTING" == "1" ]]; then
		bash -c "$1"
	else
		echo
		$_gum spin \
		  --show-error \
		  --spinner line \
		  --spinner.foreground="#cccccc" \
		  --title ">>> $title ..." \
		  --title.foreground="#cccccc" \
		    -- bash -c "$1"
		echo -en "\033[2A\033[K"
	fi
}

