CLICOLOR=1
export CLICOLOR
LSCOLORS=ExFxCxDxBxegedabagacad
export LSCOLORS
PS1="\u@\h$ "
PATH="/Library/PostgreSQL/9.3/bin:/usr/local/bin:${PATH}"
PATH="/usr/local/Cellar/ghostscript/9.10_1/bin:${PATH}"
PATH="/Users/michiel/Library/Python/2.7/bin:${PATH}"
export PATH
export ARCHFLAGS="-arch x86_64 -arch i386 -Wno-error=unused-command-line-argument-hard-error-in-future" # For compilation under Mavericks.
export C_INCLUDE_PATH="/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.9.sdk/usr/include/libxml2/:/Library/PostgreSQL/9.3/lib:${C_INCLUDE_PATH}"
export SVN_EDITOR=vim

#PATH="/Users/michiel/source/Android/android-sdk-macosx/platform-tools:${PATH}"
#export PATH
powerline-daemon -q
POWERLINE_BASH_CONTINUATION=1
POWERLINE_BASH_SELECT=1
. /Users/michiel/Library/Python/2.7/lib/python/site-packages/powerline/bindings/bash/powerline.sh
