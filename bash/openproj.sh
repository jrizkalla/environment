# Open .xcodeproj file in any parent directory using the verison of xcode pointed to by xcode-select

if [ $# -ne 0 ]; then
    echo 'Usage: openproj' >&2
    exit 1
fi

# find the correct version of xcode
xcode_loc="$(cd `xcode-select -p` && cd ../.. && pwd)"

cwd="$(pwd)"
while [ "$(pwd)" != "/" ]; do
    xcode_proj="$((ls -d *.xcodeproj) 2>/dev/null)"
    if [ $? -eq 0 ]; then break; fi
    cd ..
done
xcode_dir="$(pwd)"
cd "$cwd"

if [ -z "$xcode_proj" ]; then
    echo "Error: no .xcodeproj file found" >&2
    exit 1
fi
echo open -a $xcode_loc "$xcode_dir/$xcode_proj"
open -a "$xcode_loc" "$xcode_dir/$xcode_proj"
