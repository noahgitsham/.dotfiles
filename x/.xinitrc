xsetroot -cursor_name left_ptr
xrandr --output HDMI-A-0 --auto --left-of eDP
export _JAVA_AWT_WM_NONREPARENTING=1

picom &
~/.fehbg &
$HOME/.config/polybar/launch.sh &
dunst &
exec dwm
