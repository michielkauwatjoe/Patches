# Bash customization.
CLICOLOR=1
export CLICOLOR
LSCOLORS=ExFxCxDxBxegedabagacad
export LSCOLORS
PS1="-@-@- $ "
export CUDA_HOME=/usr/local/cuda

# Python / python path extensions.
alias python=python3
PATH="/Library/Frameworks/Python.framework/Versions/3.8/bin:${PATH}"
PATH="/usr/local/opt/python/libexec/bin:$PATH"

# Other Path extensions. Reverse order.
# Python paths.
PATH="/usr/local/bin:$PATH"
PATH="$CUDA_HOME/bin:$PATH"
PATH="/usr/bin:${PATH}"
PATH="/Library/PostgreSQL/9.3/bin:${PATH}"
PATH="/usr/local/Cellar/ghostscript/9.10_1/bin:${PATH}"
export PATH

# Library dependency paths.
LD_LIBRARY_PATH="$CUDA_HOME/lib:${LD_LIBRARY_PATH}"
DYLD_LIBRARY_PATH="$CUDA_HOME/lib:${DYLD_LIBRARY_PATH}"

# Architecture flags.
#export ARCHFLAGS="-arch x86_64 -arch i386 -Wno-error=unused-command-line-argument-hard-error-in-future" # For compilation under Mavericks.

# Locale.
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# Ruby environment.
#export PATH="$HOME/.rbenv/bin:$PATH"
#eval "$(rbenv init -)"

