# headset-battery-widget
Outputs battery levels as a fancy indicator, so it can be used for widgets in Linux (whatever panel you like that supports command output).

## Dependencies

* `headsetcontrol` needs to be installed: https://github.com/Sapd/HeadsetControl
* Any Nerd font (https://www.nerdfonts.com) if you want to use fancy icons for the headset and indicator levels, like the default pulses, or circles or whatnot. Otherwise, customize to use ASCII icons or whatever you'd like.

## Usage

Add a widget to the panel in your DE of choice (KDE, hyprland etc). In KDE for example, it's the "Command Output" widget. Paste the contents oif `headset_indicator.sh` and configure it to run every x seconds or minutes.

## Customization

Change the CONFIGURATION section if you want other icons or more divisors (discrete levels, e.g. now it's based on my Arctis headset only reporting discrete values like 12%, 25% etc).

## Bazzite instructions:

I installed headsetcontrol in a distrobox container (let's call it Arch) and changed the LEVEL variable to this:
`LEVEL=$(distrobox-enter Arch -- /usr/local/bin/headsetcontrol -b | grep "Level:" | awk '\''{print $2}'\'' | sed "s/%//");`

## Screenshots:

Headset off:
<img width="58" height="79" alt="image" src="https://github.com/user-attachments/assets/03994c2d-6f0f-43ae-a526-42a9998436b8" />

Low battery (~12%):
<img width="209" height="74" alt="image" src="https://github.com/user-attachments/assets/3321d9fb-a2dc-4a60-b91b-f2c02c887939" />

Full battery:
<img width="209" height="74" alt="image" src="https://github.com/user-attachments/assets/26903a6b-379c-498d-82d8-175228d4452d" />
