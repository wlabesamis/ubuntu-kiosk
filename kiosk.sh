#!/bin/bash

xset -dpms
xset s off
openbox-session &
start-pulseaudio-x11

while true; do
  rm -rf ~/.{config,cache}/google-chrome/
  google-chrome --kiosk --no-first-run  'http://thepcspy.com'
done