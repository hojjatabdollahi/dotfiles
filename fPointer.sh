#!/bin/sh
xinput list | grep "ELAN" | sed -E "s/.*id=([0-9]+).*/\\1/" | xargs xinput --disable
