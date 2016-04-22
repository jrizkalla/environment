source $HOME/.bash_profile

logger -s Running powerconnected.sh 2>> ~/Library/Logs/scripts.log
echo 'tell current application
    set volume without output muted
    end tell' | osascript 2>&1 | logger -s 2>> ~/Library/Logs/scripts.log
    
# This part requires root privaleges so:
if [ "$(whoami)" == "root" ]; then
    mkdir /Volumes/John
    mkdir /Volumes/Documents
    mount -t hfs /dev/disk2s2 /Volumes/John | logger -s 2>> ~/Library/Logs/scripts.log
    mount -t hfs /dev/disk2s3 /Volumes/Documents | logger -s 2>> ~/Library/Logs/scripts.log
else
    logger -s "Unable to mount disk2s2 and disk2s3 because I need root privaleges" 2>> ~/Library/Logs/scripts.log
fi
