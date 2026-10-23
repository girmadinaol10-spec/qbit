# Qbit Linux default zsh setup (edit freely)
HISTFILE=~/.zsh_history
HISTSIZE=5000
SAVEHIST=5000
setopt HIST_IGNORE_DUPS SHARE_HISTORY APPEND_HISTORY
setopt CORRECT          # offers to fix mistyped commands
setopt AUTO_CD
autoload -Uz compinit && compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
autoload -Uz colors && colors
alias ls='ls --color=auto'
alias grep='grep --color=auto'
PROMPT='%F{cyan}%n@%m%f:%F{blue}%~%f %# '

# --- imported from the author's own setup ---
setopt PROMPT_SUBST
PROMPT='%B%F{cyan}%n@%m%f:%F{yellow}%~%f %F{green}%%%f%b '
PROMPT='%F{green}%n@%m:%~%f %# '

# plugins installed by apt (syntax highlighting must be loaded last)
[ -f /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh ] && source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
[ -f /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ] && source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
