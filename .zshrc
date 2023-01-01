if [[ "$TERM" != 'linux' ]]
then
	neofetch

	# Enable Powerlevel10k instant prompt
	if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
		source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
	fi

	# Path oh-my-zsh installation
	export ZSH="$HOME/.local/share/oh-my-zsh"

	# Theme
	ZSH_THEME="powerlevel10k/powerlevel10k"

	# Command execution time stamp shown in the history command output
	HIST_STAMPS="yyyy-mm-dd"

	# Theme Catppuccin Mocha for zsh-syntax-highlighting plugin
	source $ZSH/custom/themes/catppuccin_mocha-zsh-syntax-highlighting.zsh

	# Additional completion definitions (zsh-completions plugin)
	fpath+=${ZSH_CUSTOM:-${ZSH:-~/.local/share/oh-my-zsh}/custom}/plugins/zsh-completions/src

	plugins=(archlinux git zsh-autosuggestions zsh-syntax-highlighting)

	source $ZSH/oh-my-zsh.sh

	# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
	[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
else
	if [[ -z $DISPLAY ]] && [[ "$(tty)" = "/dev/tty1" ]]
	then
		exec "$HOME"/.local/bin/scripts/ssway.sh
	else
		# Path oh-my-zsh installation
		export ZSH="$HOME/.local/share/oh-my-zsh"

		# Theme
		ZSH_THEME="philips"

		# Command execution time stamp shown in the history command output
		HIST_STAMPS="yyyy-mm-dd"

		plugins=(archlinux git)

		source $ZSH/oh-my-zsh.sh

		# Aliases
		alias nvim="XDG_CONFIG_HOME= /usr/bin/nvim"
		alias ssway="$HOME/.local/bin/scripts/ssway.sh"
	fi
fi
