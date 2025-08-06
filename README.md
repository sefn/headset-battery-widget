# headset-battery-widget
Outputs battery levels as a fancy indicator, so it can be used for widgets in Linux (whatever panel you like that supports command output).

## Dependencies

* `headsetcontrol` needs to be installed: https://github.com/Sapd/HeadsetControl
* Nerd font if you want to use fancy icons for the headset and indicator levels, like the pulses or circles or whatnot. Otherwise, customize to use ASCII icons or whatever you'd like.

## Usage

Add a widget to the panel in your DE of choice (KDE, hyprland etc). In KDE for example, it's the "Command Output" widget. Paste this and configure it to run every x seconds or minutes:

bash -c '
# --- CONFIGURATION ---
TOTAL_BLOCKS=8
DIVISOR=12 
ICON_FILLED="" 
ICON_EMPTY=""
ICON_HEADSET="󰋎"
ICON_DISCONNECTED="󰋐"
# ---------------------

LEVEL=$(headsetcontrol -b | grep "Level:" | awk '\''{print $2}'\'' | sed "s/%//");

if [ -z "$LEVEL" ]; then
    echo "$ICON_DISCONNECTED";
else
    BLOCKS=$(($LEVEL / DIVISOR));
    
    # Ensure at least one block shows if there is any charge
    if [ "$LEVEL" -gt 0 ] && [ "$BLOCKS" -eq 0 ]; then
        BLOCKS=1;
    fi;
    
    BAR="";
    # Loop to add filled blocks
    for i in $(seq 1 $BLOCKS 2>/dev/null); do 
        BAR="${BAR}${ICON_FILLED}"; 
    done;
    
    # Loop to add empty blocks
    for i in $(seq 1 $((TOTAL_BLOCKS - BLOCKS)) 2>/dev/null); do 
        BAR="${BAR}${ICON_EMPTY}"; 
    done;
    
    echo " $ICON_HEADSET ${BAR} ";
fi'

## Customization

Change the CONFIGURATION section if you want other icons or more divisors (discrete levels, e.g. now it's based on my Arctis headset only reporting discrete values like 12%, 25% etc).

## Bazzite instructions:

I installed headsetcontrol in a distrobox container (let's call it Arch) and changed the LEVEL variable to this:
LEVEL=$(distrobox-enter Arch -- /usr/local/bin/headsetcontrol -b | grep "Level:" | awk '\''{print $2}'\'' | sed "s/%//");
