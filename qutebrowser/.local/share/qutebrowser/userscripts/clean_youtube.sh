#!/bin/bash
echo "open http://viewpure.com/$(echo $QUTE_URL | cut -d '=' -f 2)" >> "$QUTE_FIFO"
