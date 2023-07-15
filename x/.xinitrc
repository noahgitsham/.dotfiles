xsetroot -cursor_name left_ptr
xrandr --output HDMI-A-0 --auto --left-of eDP

picom &
~/.fehbg &
$HOME/.config/polybar/launch.sh &
dunst &
xmousepasteblock &
exec bspwm
