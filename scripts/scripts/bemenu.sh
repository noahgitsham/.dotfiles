#!/bin/sh

j4-dmenu-desktop --dmenu="bemenu --ifne \
	--fn='Terminus 14' \
	--no-cursor \
	--cw 2 \
	--ch 14 \
	-i -c \
	-l 10 \
	-P '>' \
	-n -W 0.5 \
	--tb=#A89984 --tf=#1D2021 \
	--nb=#1D2021 --nf=#A89984 \
	--ab=#1D2021 --af=#A89984 \
	--hb=#1D2021 --hf=#8EC07C \
	--fb=#1D2021 --ff=#FBF1C7 \
	-B 1 --bdr=#A89984 \
	"
	#--vim-esc-exits \
