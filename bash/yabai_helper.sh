function current_window_info {
    yabai -m query --windows | jq '.[] | select(."has-focus")'
}
function current_window_is_floating {
    current_window_info | jq '."is-floating"'
}
function current_window_is_zoomed {
    current_window_info | jq '."has-fullscreen-zoom"'
}


function unzoom_if_zoomed {
    if [ "$(current_window_is_zoomed)" = "true" ]; then
        yabai -m window --toggle zoom-fullscreen
    fi
}


function swap_or_resize {
    if [ "$(current_window_is_floating)" = "true" ]; then
        yabai -m window --grid "$2"
    else
        yabai -m window --swap "$1"
    fi
}

function user_input {
    prompt_text="$1"

    osascript -l JavaScript <<END
var app = Application.currentApplication();
app.includeStandardAdditions = true;

var response = app.displayDialog("${prompt_text}", {
    defaultAnswer: "",
    withIcon: "note",
    buttons: ["Cancel", "Continue"],
    defaultButton: "Continue"
});
response.textReturned;
END
}

function clean_empty_spaces {
    while true; do
        first_empty_space="$(yabai -m query --spaces | jq 'map(select(.windows == [])) | first | .index')"
        if [ "$first_empty_space" = "null" ]; then break; fi
        echo "Deleting space $first_empty_space"

        yabai -m space --destroy $first_empty_space
    done
}


cmd=$1

case $cmd in
rcmd_semi)
    result="$(user_input 'Where?')"
    echo $result
;;
rcmd_l)
    swap_or_resize east 1:2:1:0:1:1
;;

rcmd_h)
    swap_or_resize west 1:2:0:0:1:1
;;

rcmd_k)
    swap_or_resize north 2:1:0:0:1:1
;;

rcmd_j)
    swap_or_resize south 2:1:0:1:1:1
;;

rcmd_z)
    if [ "$(current_window_is_floating)" = "true" ]; then
        yabai -m window --grid 1:1:0:0:1:1
    else
        yabai -m window --toggle zoom-fullscreen
    fi
;;
cmd_ctrl_h)
    unzoom_if_zoomed && yabai -m window --focus west
;;
cmd_ctrl_l)
    unzoom_if_zoomed && yabai -m window --focus east
;;
cmd_ctrl_k)
    unzoom_if_zoomed && yabai -m window --focus north
;;
cmd_ctrl_j)
    unzoom_if_zoomed && yabai -m window --focus south
;;

rcmd_ctrl_h)
    yabai -m window --space prev && yabai -m space --focus prev
;;
rcmd_ctrl_l)
    yabai -m window --space next && yabai -m space --focus next
;;

rcmd_shift_f)
    type="$(yabai -m query --spaces | jq '.[] | select(."has-focus").type')"
    if [ "$type" == '"bsp"' ]; then
        yabai -m space --layout float
    else
        yabai -m space --layout bsp
    fi
;;

clean_spaces)
    clean_empty_spaces
;;

*)
    echo "UNKNOWN COMMAND"
    exit 1
esac

