bash -c '
# --- CONFIGURATION ---
TOTAL_BLOCKS=8
DIVISOR=12 
ICON_FILLED="" 
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
