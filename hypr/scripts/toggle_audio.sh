#!/usr/bin/bash

SINK1="alsa_output.pci-0000_0c_00.4.analog-stereo"
SINK2="alsa_output.usb-streamplify_Mic._streamplify_Mic._20200508V100-00.analog-stereo"

current=$(pactl get-default-sink)

if [[ "$current" == "$SINK1" ]]; then
  next="$SINK2"
else
  next="$SINK1"
fi

pactl set-default-sink "$next"
