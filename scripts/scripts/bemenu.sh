#!/bin/sh

j4-dmenu-desktop --dmenu="bemenu --binding=vim \
	--vim-esc-exits \
	--fn='Terminus 14' \
	--no-cursor \
	-i -c \
	-l 10 \
	-P '>' \
	-n -W 0.5 \
	--tb=#FC935C --tf=#1D2021 \
	--nb=#1D2021 --nf=#FBF1C7 \
	--ab=#1D2021 --af=#FBF1C7 \
	--hb=#1D2021 --hf=#FC935C \
	--fb=#1D2021 --ff=#FC935C \
	-B 2 --bdr=#595959 \
	"
