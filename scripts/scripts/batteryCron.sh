* * * * * [ $(cat /sys/class/power_supply/BAT0/capacity) -lt 20] && ["$(cat /sys/class/power_supply/BAT0/status)" -e "discharging"] dunstify -u critical "Battery Low"
