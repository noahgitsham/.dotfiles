# Defaults
export EDITOR="nvim"
export SUDO_EDITOR="nvim"
export TERMINAL="foot"
export TERM="foot"
export BROWSER="firefox"

#XDG
export XDG_DATA_HOME=$HOME/.local/share
export XDG_CONFIG_HOME=$HOME/.config
export XDG_STATE_HOME=$HOME/.local/state
export XDG_CACHE_HOME=$HOME/.cache

# Path
path+=("$HOME/.local/bin")
path+=("$HOME/scripts")
export PATH

# Directories
export VST_PATH=/usr/lib/vst/

# Wine
export ABLETON_DIR="$HOME/software/wine/Ableton/drive_c/ProgramData/Ableton/Live 11 Suite/"

# Fuck you microsoft
export DOTNET_CLI_TELEMETRY_OPTOUT=1

# Dmenu replacement
export BEMENU_OPTS="--ifne \
	--fn=Terminus 18 \
	--no-cursor \
	--cw 2 \
	--ch 14 \
	-i -c \
	-l 10 \
	-P '>' \
	-n -W 0.5 \
	--tb=#60605F --tf=#FFFFFF \
	--nb=#FFFFFF --nf=#60605F \
	--ab=#FFFFFF --af=#60605F \
	--hb=#FFFFFF --hf=#F5871F \
	--fb=#FFFFFF --ff=#4D4D4C \
	--bdr=#60605F"

	#--tb=#A89984 --tf=#1D2021 \
	#--nb=#1D2021 --nf=#A89984 \
	#--ab=#1D2021 --af=#A89984 \
	#--hb=#1D2021 --hf=#8EC07C \
	#--fb=#1D2021 --ff=#FBF1C7 \
	#--bdr=#A89984"


# XDG User #Directories
export HISTFILE="$XDG_STATE_HOME"/zsh/history
export ANDROID_HOME="$XDG_DATA_HOME"/android
export CARGO_HOME="$XDG_DATA_HOME"/cargo
export RUSTUP_HOME="$XDG_DATA_HOME"/rustup
export GNUPGHOME="$XDG_DATA_HOME"/gnupg
export GTK2_RC_FILES="$XDG_CONFIG_HOME"/gtk-2.0/gtkrc
export IPYTHONDIR="${XDG_CONFIG_HOME}/ipython"
export JUPYTER_CONFIG_DIR="$XDG_CONFIG_HOME"/jupyter
export NODE_REPL_HISTORY="$XDG_DATA_HOME"/node_repl_history
export WINEPREFIX="$XDG_DATA_HOME"/wine
export XAUTHORITY="$XDG_RUNTIME_DIR"/Xauthority
export PARALLEL_HOME="$XDG_CONFIG_HOME"/parallel
export PYTHONSTARTUP="${XDG_CONFIG_HOME}/python/pythonrc"
export BUNDLE_USER_CONFIG="$XDG_CONFIG_HOME"/bundle
export BUNDLE_USER_CACHE="$XDG_CACHE_HOME"/bundle
export BUNDLE_USER_PLUGIN="$XDG_DATA_HOME"/bundle
export OLLAMA_MODELS="$XDG_DATA_HOME"/ollama/models
export DOTNET_CLI_HOME="$XDG_DATA_HOME"/dotnet
export NPM_CONFIG_USERCONFIG=$XDG_CONFIG_HOME/npm/config
export NPM_CONFIG_CACHE=$XDG_CACHE_HOME/npm
export NPM_CONFIG_TMP=$XDG_RUNTIME_DIR/npm
export SQLITE_HISTORY="$XDG_CACHE_HOME"/sqlite_history
export NUGET_PACKAGES="$XDG_CACHE_HOME"/NuGetPackages
export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME"/java
export W3M_DIR="$XDG_DATA_HOME"/w3m
export XINITRC="$XDG_CONFIG_HOME"/xinitrc
export GOPATH="$XDG_DATA_HOME"/go
export GRADLE_USER_HOME="$XDG_DATA_HOME"/gradle
export MPLAYER_HOME="$XDG_CONFIG_HOME"/mplayer
export ANDROID_USER_HOME="$XDG_DATA_HOME"/android
alias adb='HOME="$XDG_DATA_HOME"/android adb'
alias units=units --history "$XDG_DATA_HOME"/units_history
alias wget=wget --hsts-file="$XDG_DATA_HOME/wget-hsts"
