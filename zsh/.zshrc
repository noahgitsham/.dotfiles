#zmodload zsh/zprof
# History
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS
setopt histignorealldups
HISTFILE=~/.histfile
HISTSIZE=50000
SAVEHIST=50000

#unsetopt beep

# Vim keybinds
source /usr/share/zsh/plugins/zsh-vi-mode/zsh-vi-mode.plugin.zsh
#function zvm_after_init() {
#}

# bindkey -v '^?' backward-delete-char
# bindkey '^R' history-incremental-search-backward
# KEYTIMEOUT=1

# Set the default WORDCHARS
WORDCHARS='*?_[]~=&;!#$%^(){}<>'

# The plugin will auto execute this zvm_after_init function
function zvm_after_init() {
  zvm_bindkey viins '^W' zle backward-kill-word
}


# fzf history completion
zvm_after_init_commands+=('source /usr/share/fzf/key-bindings.zsh')

# Completion
zstyle :compinstall filename '~/.zshrc'

# Completion
autoload -Uz compinit
# XDG
mkdir -p "$XDG_CACHE_HOME"/zsh
compinit -d "$XDG_CACHE_HOME"/zsh/zcompdump-"$ZSH_VERSION"

# Path
path+=("$HOME/scripts")
export PATH

### Custom prompt
##setopt PROMPT_SUBST
##
### Git prompt
##autoload -Uz vcs_info
##precmd_vcs_info() { vcs_info }
##precmd_functions+=( precmd_vcs_info )
##vcs_colour=blue
##
##make_prompt() {
##	if [[ -z ${vcs_info_msg_0_} ]] then
##		PROMPT="%F{yellow}%n%f %F{gray}$%f "
##	else
##		PROMPT="%F{yellow}%n%f %F{${vcs_colour}}${vcs_info_msg_0_}%f %F{gray}$%f "
##	fi
##}
##
##precmd_functions+=make_prompt
##
### RPROMPT='%F{${vcs_colour}}${vcs_info_msg_0_}%f'
##
### Format to branch name only
##zstyle ":vcs_info:git:*" formats "%b"

eval "$(starship init zsh)"

# Syntax Highligting
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

source /home/noah/.config/broot/launcher/bash/br


# Login Message
if [[ -z $DISPLAY ]] then
	echo "Battery: $(cat /sys/class/power_supply/BAT0/capacity)%"
	echo '
    /|
   (% 7
   |  \
   lU_,)/
'
fi


# Rehash after package install
zshcache_time="$(date +%s%N)"
autoload -Uz add-zsh-hook

rehash_precmd() {
	if [[ -a /var/cache/zsh/pacman ]]; then
		local paccache_time="$(date -r /var/cache/zsh/pacman +%s%N)"
		if (( zshcache_time < paccache_time )); then
			rehash
			zshcache_time="$paccache_time"
		fi
	fi
}

add-zsh-hook -Uz precmd rehash_precmd


# Foot terminal scrollback Integration
precmd() {
    print -Pn "\e]133;A\e\\"
}


# Aliases
alias ls="ls --color"
alias less="less --color=always | less -R"
alias tree="tree -C"
alias tmuxa="tmux a || tmux"

#alias emacs="emacs -nw"

INITIAL_QUERY="${*:-}"
RG_PREFIX="rg --column --line-number --no-heading --color=always --smart-case "
alias fzrg=": | fzf --ansi --disabled --query \"$INITIAL_QUERY\" \
    --bind \"start:reload:$RG_PREFIX {q}\" \
    --bind \"change:reload:sleep 0.1; $RG_PREFIX {q} || true\" \
    --delimiter : \
    --preview 'bat --color=always {1} --highlight-line {2}' \
    --preview-window 'up,60%,border-bottom,+{2}+3/3,~3' \
    --bind 'enter:become(vim {1} +{2})'"

RG_HIDDEN_PREFIX="${RG_PREFIX}--hidden "
alias fzrgh=": | fzf --ansi --disabled --query \"$INITIAL_QUERY\" \
    --bind \"start:reload:$RG_HIDDEN_PREFIX {q}\" \
    --bind \"change:reload:sleep 0.1; $RG_HIDDEN_PREFIX {q} || true\" \
    --delimiter : \
    --preview 'bat --color=always {1} --highlight-line {2}' \
    --preview-window 'up,60%,border-bottom,+{2}+3/3,~3' \
    --bind 'enter:become(vim {1} +{2})'"

#zprof
