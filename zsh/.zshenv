# Defaults
export EDITOR="nvim"
export SUDO_EDITOR="nvim"
export TERMINAL="foot"
export TERM="foot"
export BROWSER="firefox"
#export PAGER="bat -p"

# Themes
export BAT_THEME="gruvbox-dark"

# Directories
export VST_PATH=/usr/lib/vst/

# Wine
export ABLETON_DIR="$HOME/software/wine/Ableton/drive_c/ProgramData/Ableton/Live 11 Suite/"

#XDG
export XDG_DATA_HOME=$HOME/.local/share
export XDG_CONFIG_HOME=$HOME/.config
export XDG_STATE_HOME=$HOME/.local/state
export XDG_CACHE_HOME=$HOME/.cache

export HISTFILE="$XDG_STATE_HOME"/zsh/history

export ANDROID_HOME="$XDG_DATA_HOME"/android
export HISTFILE="${XDG_STATE_HOME}"/bash/history
export CARGO_HOME="$XDG_DATA_HOME"/cargo
export RUSTUP_HOME="$XDG_DATA_HOME"/rustup
export GNUPGHOME="$XDG_DATA_HOME"/gnupg
export GTK2_RC_FILES="$XDG_CONFIG_HOME"/gtk-2.0/gtkrc
export IPYTHONDIR="${XDG_CONFIG_HOME}/ipython"
export JUPYTER_CONFIG_DIR="$XDG_CONFIG_HOME"/jupyter
export NODE_REPL_HISTORY="$XDG_DATA_HOME"/node_repl_history
alias units=units --history "$XDG_DATA_HOME"/units_history
alias wget=wget --hsts-file="$XDG_DATA_HOME/wget-hsts"
export WINEPREFIX="$XDG_DATA_HOME"/wine
export XAUTHORITY="$XDG_RUNTIME_DIR"/Xauthority
export PARALLEL_HOME="$XDG_CONFIG_HOME"/parallel
export PYTHONSTARTUP="${XDG_CONFIG_HOME}/python/pythonrc"
export BUNDLE_USER_CONFIG="$XDG_CONFIG_HOME"/bundle
export BUNDLE_USER_CACHE="$XDG_CACHE_HOME"/bundle
export BUNDLE_USER_PLUGIN="$XDG_DATA_HOME"/bundle
export OLLAMA_MODELS="$XDG_DATA_HOME"/ollama/models
