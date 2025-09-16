item=$(echo $1 | awk '{print $1}')
op item get $item
