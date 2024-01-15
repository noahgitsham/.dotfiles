xsetroot -cursor_name left_ptr
xrandr --output HDMI-A-0 --rotate left --auto --left-of eDP
xset r rate 250 30

#kitty &
#exec /home/noah/programming/wm/xwm/wm
#exec kitty

picom &
~/.fehbg &
$HOME/.config/polybar/launch.sh &
dunst &
xmousepasteblock &
emacs --daemon &
exec bspwm

#exec herbstluftwm
