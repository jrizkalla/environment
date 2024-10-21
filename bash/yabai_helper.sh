function current_window_info {
    yabai -m query --windows | jq '.[] | select(."has-focus")'
}
function current_window_is_floating {
    current_window_info | jq '."is-floating"'
}


function warp_or_resize {
    if [ "$(current_window_is_floating)" = "true" ]; then
        yabai -m window --grid "$2"
    else
        yabai -m window --warp "$1"
    fi
}

cmd=$1

case $1 in
rcmd_l)
    warp_or_resize east 1:2:1:0:1:1
;;

rcmd_h)
    warp_or_resize west 1:2:0:0:1:1
;;

rcmd_k)
    warp_or_resize north 2:1:0:0:1:1
;;

rcmd_j)
    warp_or_resize south 2:1:0:1:1:1
;;

rcmd_z)
    if [ "$(current_window_is_floating)" = "true" ]; then
        yabai -m window --grid 1:1:0:0:1:1
    else
        yabai -m window --toggle zoom-fullscreen
    fi
;;

*)
    echo "UNKNOWN COMMAND"
    exit 1
esac

