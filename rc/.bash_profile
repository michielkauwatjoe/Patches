# Bash customization.
CLICOLOR=1
export CLICOLOR
LSCOLORS=ExFxCxDxBxegedabagacad
export LSCOLORS
PS1="\u@\h$ "

# Path extensions. Reverse order.
PATH="/usr/local/sbin:$PATH"
PATH="/usr/local/bin:$PATH"
PATH="/usr/local/cuda/bin:$PATH"
PATH="/usr/bin:${PATH}"

PATH="/Library/PostgreSQL/9.3/bin:${PATH}"
PATH="/usr/local/Cellar/ghostscript/9.10_1/bin:${PATH}"
PATH="/Users/michiel/Library/Python/2.7/bin:${PATH}"
export PATH

# Library dependency paths.
LD_LIBRARY_PATH="/usr/local/cuda/lib64:${LD_LIBRARY_PATH}"
export LD_LIBRARY_PATH

# Architecture flags.
export ARCHFLAGS="-arch x86_64 -arch i386 -Wno-error=unused-command-line-argument-hard-error-in-future" # For compilation under Mavericks.

# C includes.
#export C_INCLUDE_PATH="/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.9.sdk/usr/include/libxml2/:/Library/PostgreSQL/9.3/lib:${C_INCLUDE_PATH}"

# Editors.
export SVN_EDITOR=vim

# Locale.
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# Powerline prompt.
powerline-daemon -q
POWERLINE_BASH_CONTINUATION=1
POWERLINE_BASH_SELECT=1
. /Users/michiel/Library/Python/2.7/lib/python/site-packages/powerline/bindings/bash/powerline.sh


# Ruby environment.
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
#rbenv global 2.1.2 
#rbenv global 1.1.0-2-g4f8925a
