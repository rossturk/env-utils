_gum=${_gum:-@gum@}
_gum=${_gum//@/}

fxspin {
    local title=$1
    shift
    local command=("$@")

    # TODO: check to see if we are non-interactive
    $_gum spin --spinner dot --title "$title" -- "$command"
}

fxbox {
    gum style --border double --margin "1 2" --padding "1 4" $@
}

