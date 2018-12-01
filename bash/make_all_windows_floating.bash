#!/usr/bin/env bash

pkill -f make_all_windows_floating.bash

while [ 1 ]; do
    chunkc set window_float_next 1
    sleep 2;
done
