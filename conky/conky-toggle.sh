#!/bin/sh

# click to start, click to stop

if pidof conky | grep [0-9] > /dev/null
then
 exec killall conky
else
 exec conky -c ~/src/misc/conky/reddit-widget-1

fi
