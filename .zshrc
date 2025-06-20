# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded. See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="steeef"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
#export LANG=zh_CN.UTF-8
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
#
#
alias rc=rclone
alias vim=nvim

set_proxy () {
  export ALL_PROXY="socks5://127.0.0.1:1080"
  export all_proxy="socks5://127.0.0.1:1080"
  echo -e "Acquire::http::Proxy \"http://127.0.0.1:1090\";" | sudo tee -a /etc/apt/apt.conf > /dev/null
  echo -e "Acquire::https::Proxy \"http://127.0.0.1:1090\";" | sudo tee -a /etc/apt/apt.conf > /dev/null
}

unset_proxy () {
  unset ALL_PROXY
  unset all_proxy
  sudo sed -i -e '/Acquire::http::Proxy/d' /etc/apt/apt.conf
  sudo sed -i -e '/Acquire::https::Proxy/d' /etc/apt/apt.conf
}

export GOPATH=$HOME/gopkg
export GOROOT=/usr/local/go/
export GOBIN=/usr/local/go/bin

export PATH=$PATH:$GOBIN

export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"

. $HOME/z.sh

alias pst='TZ="America/Los_Angeles" date'
alias beijing='TZ="Asia/Shanghai" date'

export FZF_DEFAULT_OPTS="--cycle --inline-info --no-height"
source $HOME/fzf/completion.zsh
source $HOME/fzf/key-bindings.zsh

t() { if [ $# -eq 0 ]; then echo -e "No arguments specified. Usage:\necho transfer /tmp/test.md\ncat /tmp/test.md | transfer test.md"; return 1; fi 
    tmpfile=$( mktemp -t transferXXX ); if tty -s; then basefile=$(basename "$1" | sed -e 's/[^a-zA-Z0-9._-]/-/g'); curl --progress-bar --upload-file "$1" "https://transfer.sh/$basefile" >> $tmpfile; else curl --progress-bar --upload-file "-" "https://transfer.sh/$1" >> $tmpfile ; fi; cat $tmpfile; rm -f $tmpfile; }


alias xclip='xclip -selection c'

export PATH=$HOME/.tiup/bin:$PATH:$HOME/Library/Python/3.8/bin
export NVS_HOME="$HOME/.nvs"
[ -s "$NVS_HOME/nvs.sh" ] && . "$NVS_HOME/nvs.sh"

export PATH="/opt/homebrew/opt/mysql-client/bin:$PATH"

export DENO_INSTALL="$HOME/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"
export PATH="/home/dongxu/.local/bin:$PATH"
export PATH="/Users/dongxu/Library/Python/3.9/bin:$PATH"

xclip_text() {
    xclip -selection clipboard -o
}

xclip_img() {
    xclip -selection clipboard -t image/png -o
}


get_xclip() {
    out=$(xclip -selection clipboard -t TARGETS -o | grep "image")
    [[ -n $out ]] && xclip_img || xclip_text
}

pf() {
    url=$(get_xclip | curl -X PUT --data-binary @- lucy:8100/f/clip-$(date "+%F-%H-%M-%S") 2>/dev/null)
    echo http://lucy:8100$url
}

jj() { vim $HOME/Dropbox/jj/log-`date "+%Y-%m-%d"`.md }

export NVM_DIR="$HOME/.nvm"
#[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
#[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export PATH="/opt/homebrew/opt/mysql-client/bin:$PATH"

node17() {
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
    nvm use 17.0
}

export PATH="$PATH:/Users/dongxu/.bin"

# Created by `pipx` on 2023-05-18 21:39:03
export PATH="$PATH:/Users/dongxu/.local/bin"

export PATH="$PATH:/Users/dongxu/.tip/bin"

alias now="date +'%Y-%m-%d-%H-%M-%S'"

export PATH=/Users/dongxu/.ticloud/bin:$PATH

# Added by LM Studio CLI (lms)
export PATH="$PATH:/Users/dongxu/.lmstudio/bin"
# End of LM Studio CLI section

