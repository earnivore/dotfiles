# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to GoLang installation
export PATH=$PATH:/usr/local/go/bin

# Path to GoLang binaries
export PATH=$PATH:~/go/bin

# Path to your oh-my-zsh installation.
export ZSH="$(echo ~)/.oh-my-zsh"

# Set the TTY for GPG
export GPG_TTY=$(tty)

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="intheloop"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git kubectl gcloud cp zsh-autosuggestions terraform vscode)

source $ZSH/oh-my-zsh.sh

# User configuration

# aliases
alias e="emacsclient --tty"
alias tf="terraform"

## aliases for gcloud configurations
alias gcl="gcloud config list"
alias gcca="gcloud config configurations activate"
alias gccl="gcloud config configurations list"

# Export an alternative editor so the Emacs server automatically starts
export ALTERNATE_EDITOR=""

# Start TMUX on every shell login
# https://unix.stackexchange.com/questions/43601/how-can-i-set-my-default-shell-to-start-up-tmux
if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
  exec tmux
fi

# Add bindings to Vim CLI mode
bindkey -v
bindkey "^R" history-incremental-search-backward
bindkey -M viins 'jk' vi-cmd-mode

# add zoxide
eval "$(zoxide init zsh)"

# add Kubectl Krew plugin manager
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"


# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/jackson.reid/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/jackson.reid/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/jackson.reid/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/jackson.reid/google-cloud-sdk/completion.zsh.inc'; fi

# fzf
# the below source may differ, use apt show to see which dir to use
#source /usr/share/fzf/shell/key-bindings.zsh
source /usr/share/doc/fzf/examples/key-bindings.zsh
source /usr/share/doc/fzf/examples/completion.zsh
export FZF_CTRL_T_OPTS="--preview 'bat --style=numbers --color=always --line-range :500 {}'"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

bindkey "ç" fzf-cd-widget
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
