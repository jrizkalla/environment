#!/usr/bin/env sh

function default_css {
        cat <<END
    * {
        font-family: "Helvetica", sans-serif;
    }
    code,
    code * {
        font-family: "Courier New";
    }
END
}

which pandoc > /dev/null 2>&1
if [ $? -ne 0 ]; then
    echo "Error: please install pandoc to continue (brew install pandoc)" >&2
    exit 1
fi
which textutil > /dev/null 2>&1
if [ $? -ne 0 ]; then
    echo "Error: missing textutil command. Are you on MacOS?" >&2
    exit 1
fi

md_tmp_file=$(mktemp -t compose.md)
rtf_tmp_file=$(mktemp -t compose.rtf)
html_tmp_file=$(mktemp -t compose.html)

function cleanup {
    rm -r "$md_tmp_file"
    rm -r "$rtf_tmp_file"
    rm -r "$html_tmp_file"
}
trap cleanup EXIT

VIM=vim
which mvim >/dev/null >&2
if [ $? -eq 0 ]; then VIM="mvim --nofork"; fi

$VIM "$md_tmp_file" '+set ft=markdown'

# Create a style file
style=""
if [ -e "$HOME/.compose.css" ]; then
    style="$(cat "$HOME/compose.css")"
else
    style="$(default_css)"
fi

# Convert the file to rtf
echo "<style>$style</style>" > $html_tmp_file
pandoc "$md_tmp_file" --standalone -t html --highlight-style tango >> $html_tmp_file
cat $html_tmp_file | textutil -stdin -format html -convert rtf -output "$rtf_tmp_file"

cat "$rtf_tmp_file" | pbcopy

# For debugging. TODO: remove
cp "$rtf_tmp_file"  /tmp/compose.rtf
cp "$md_tmp_file"   /tmp/compose.md
cp "$html_tmp_file" /tmp/compose.html
