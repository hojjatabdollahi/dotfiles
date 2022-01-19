#!/bin/bash
xinput --list | grep -i touchpad | cut -f2 | cut -f2 -d= | xargs -t -I% sh -c 'xinput disable % && xinput enable %'
