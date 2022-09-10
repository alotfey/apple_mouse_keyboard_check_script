#!/bin/bash

#  create variable for the mouse
keyboard="C4:14:11:02:D9:9B"
mouse="0C:E4:41:16:EC:F2"

#  check if the keyboard is connected and return the status 1 
function check_bluetooth_keyboard {
    if [[ $(blueutil --is-connected $keyboard) -eq 1 ]]; then
        echo 'Keyboard connected'
        return 1
    else
        echo 'Keyboard and mouse not connected'
        blueutil --unpair $keyboard
        blueutil --pair $keyboard
        blueutil --connect $keyboard
        
    fi
}


#  check if the mouse is connected and return the status 1
function check_bluetooth_mouse {
    if [[ $(blueutil --is-connected $mouse) ]]; then
        echo 'mouse connected'
        return 1

    else
        echo 'mouse not connected'
        blueutil --unpair $mouse
        blueutil --pair $mouse
        blueutil --connect $mouse
        
    fi
}


# create while loop to keep checking if bluetooth keyboard and mouse are connected or not and if not, it will try to connect them if connected it will echo 'Keyboard and mouse connected' and exit 
while true; do
    check_bluetooth_keyboard
    check_bluetooth_mouse
    if [[ $(blueutil --is-connected $keyboard) -eq 1 ]] && [[ $(blueutil --is-connected $mouse) -eq 1 ]]; then
        echo 'Keyboard and mouse connected'
        exit
    fi
done



