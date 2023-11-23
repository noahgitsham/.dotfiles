# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=500
SAVEHIST=500
unsetopt beep

# Vim keybinds
bindkey -v
KEYTIMEOUT=1

# Completion
zstyle :compinstall filename '~/.zshrc'
autoload -Uz compinit
compinit

# Path
path+=("~/scripts")
export PATH

# Custom prompt
setopt PROMPT_SUBST

# Git prompt
autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
vcs_colour=blue

make_prompt() {
	if [[ -z ${vcs_info_msg_0_} ]] then
		PROMPT="%F{yellow}%n%f %F{gray}$%f "
	else
		PROMPT="%F{yellow}%n%f %F{${vcs_colour}}${vcs_info_msg_0_}%f %F{gray}$%f "
	fi
}

precmd_functions+=make_prompt

# RPROMPT='%F{${vcs_colour}}${vcs_info_msg_0_}%f'

# Format to branch name only
zstyle ":vcs_info:git:*" formats "%b"


# Syntax Highligting
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

source /home/noah/.config/broot/launcher/bash/br


# Login Message
if [[ -z $DISPLAY ]] then
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
