# Colors.
CLICOLOR=1
export CLICOLOR
LSCOLORS=ExFxCxDxBxegedabagacad
export LSCOLORS

# Prompt.
PS1="-@-@- $ "

# Python / python path extensions.
alias python=python3
alias pip=pip3
PATH="/Users/michiel/Library/Python/3.7/bin:${PATH}"
PATH="/Library/Frameworks/Python.framework/Versions/3.7/bin:${PATH}"
export PATH

PATH="/usr/bin:${PATH}"
export PATH

# Locale.
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# OpenSSL flags.
export LIBRARY_PATH=/usr/local/lib
export C_INCLUDE_PATH=/usr/local/include
export LDFLAGS="-L$(brew --prefix openssl)/lib"
export CFLAGS="-I$(brew --prefix openssl)/include"

# PostGreSQL.
#PATH="/Library/PostgreSQL/9.3/bin:${PATH}"

# CUDA.
#PATH="$CUDA_HOME/bin:$PATH"
#LD_LIBRARY_PATH="$CUDA_HOME/lib:${LD_LIBRARY_PATH}"
#DYLD_LIBRARY_PATH="$CUDA_HOME/lib:${DYLD_LIBRARY_PATH}"
#export CUDA_HOME=/usr/local/cuda

# Architecture flags (legacy).
#export ARCHFLAGS="-arch x86_64 -arch i386 -Wno-error=unused-command-line-argument-hard-error-in-future" # For compilation under Mavericks.

#export PATH="$HOME/.rbenv/bin:$PATH"
#eval "$(rbenv init -)"

