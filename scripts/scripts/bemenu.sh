#!/bin/sh

j4-dmenu-desktop --dmenu="bemenu --binding=vim \
	--vim-esc-exits \
	--fn='Terminus 14' \
	--no-cursor \
	-i -c \
	-l 10 \
	-P '>' \
	-n -W 0.5 \
	--tb=#A89984 --tf=#1D2021 \
	--nb=#1D2021 --nf=#A89984 \
	--ab=#1D2021 --af=#A89984 \
	--hb=#1D2021 --hf=#8EC07C \
	--fb=#1D2021 --ff=#FBF1C7 \
	-B 2 --bdr=#595959 \
	"
