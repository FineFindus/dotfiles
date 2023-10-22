# XDG Base Directories (https://wiki.archlinux.org/title/XDG_Base_Directory)
# Defined first, so other programs can rely on it.
export XDG_DATA_HOME=$HOME/.local/share
export XDG_CONFIG_HOME=$HOME/.config
export XDG_STATE_HOME=$HOME/.local/state
export XDG_CACHE_HOME=$HOME/.cache


# Path to oh-my-zsh installation.
export ZSH="$XDG_DATA_HOME/oh-my-zsh"

# Set name of the theme to load
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# ZSH plugins; adding too many may slow down the shell
plugins=(
    fzf
    git
    history-substring-search
    zsh-autosuggestions
    zsh-syntax-highlighting
    zsh-z
    #remove dollar sign at start from pasted commands
    undollar
)

source $ZSH/oh-my-zsh.sh

compinit -d "$XDG_CACHE_HOME"/zsh/zcompdump-"$ZSH_VERSION"


#
# User configuration
#

# Aliases

# default bat to nord theme
alias bat='bat --theme="Nord"'
# always aks before removing a file
alias rm="rm -i"
# display more information with icons
alias exa="eza -lha --icons"

# dotfiles repository
alias dotfiles='/usr/bin/git --git-dir=$HOME/.config/dotfiles/ --work-tree=$HOME'


# ENV variables

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# Improved time format for time cmd
export TIMEFMT=$'\nreal\t%*E\nuser\t%*U\nsys\t%*S'

# bin path for python installments etc…
export PATH=$PATH:~/.local/bin/

# enable gpg signing
export GPG_TTY=$(tty)

# Moving files to XDG Base Dirs, so they do not clutter $HOME

export ANDROID_HOME="$XDG_DATA_HOME"/android
export CARGO_HOME="$XDG_DATA_HOME"/cargo #this is ignored by cargo
export GNUPGHOME="$XDG_DATA_HOME"/gnupg
export GRADLE_USER_HOME="$XDG_DATA_HOME"/gradle
export LESSHISTFILE="$XDG_CACHE_HOME"/less/history
export ZSH="$XDG_DATA_HOME"/oh-my-zsh 
export RUSTUP_HOME="$XDG_DATA_HOME"/rustup
export _Z_DATA="$XDG_DATA_HOME/z"
export DOCKER_CONFIG="$XDG_CONFIG_HOME"/docker
export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME"/java

#bash/zsh files
export HISTFILE="${XDG_STATE_HOME}"/bash/history
compinit -d "$XDG_CACHE_HOME"/zsh/zcompdump-"$ZSH_VERSION" #move .zcompdump
export HISTFILE="$XDG_STATE_HOME"/zsh/history

# npm config files
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"

#android studio/flutter development
export JAVA_HOME='/usr/lib/jvm/zulu-jdk-fx'
export PATH=$JAVA_HOME/bin:$PATH 
export ANDROID_SDK_ROOT='/opt/android-sdk'
export PATH=$PATH:$ANDROID_SDK_ROOT/platform-tools/
export PATH=$PATH:$ANDROID_SDK_ROOT/tools/bin/
export PATH=$PATH:$ANDROID_SDK_ROOT/tools/
export ANDROID_AVD_HOME=~/.android/avd
export CHROME_EXECUTABLE=/usr/bin/brave


# open new taps in same directory
source /etc/profile.d/vte.sh

# show neofetch in shell start
if grep -q "ID=arch" /etc/os-release; then
    neofetch
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
