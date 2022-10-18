#!/bin/bash

# Make a new WINEPREFIX in the user's home directory entitled ".wine"
env `WINEPREFIX="/home/$(whoami)/.wine" WINEARCH="win32" wine "wineboot"`
