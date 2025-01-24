export PATH=$PATH:$HOME/.fzf/bin:$HOME/bin:$HOME/.zvm/bin:$HOME/.zvm/self:$HOME/.npm-global/bin:$HOME/.cargo/bin

if [[ $TERM_PROGRAM != "vscode" ]] && [ -z $TMUX ]; then
	exec tmux new-session
fi

# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

zinit ice as"command" from"gh-r" \
         atclone"./starship init zsh > init.zsh; ./starship completions zsh > _starship" \
         atpull"%atclone" src"init.zsh"
zinit light starship/starship

zinit ice wait lucid blockf atload"zicompinit; zicdreplay"
zinit light zsh-users/zsh-completions

zinit ice wait lucid atload'_zsh_autosuggest_start'
zinit light zsh-users/zsh-autosuggestions

zinit ice wait lucid
zinit light chisui/zsh-nix-shell

zinit ice wait lucid
zinit snippet OMZP::git

zinit ice wait lucid
zinit light zsh-users/zsh-syntax-highlighting

zinit ice depth=1
zinit light jeffreytse/zsh-vi-mode

zinit cdreplay -q

zinit snippet OMZP::git

# Load completions
autoload -Uz compinit
compinit

zinit cdreplay -q

# Keybindings
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups
setopt autocd

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no

alias vim="nvim"

export EDITOR=nvim
export TERMINAL=console
export BROWSER=web

[ -f $HOME/.cargo/env ] && . "$HOME/.cargo/env"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

command -v fzf &> /dev/null && eval "$(fzf --zsh)"

# Turso
export PATH="$PATH:/home/charlie/.turso"
