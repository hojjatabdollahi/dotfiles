#!/bin/bash
echo "options hid_apple fnmode=0" | sudo tee -a /etc/modprobe.d/hid_apple.conf
sudo mkinitcpio -P