CLICOLOR=1
LSCOLORS=ExFxCxDxBxegedabagacad
PS1="\u@\h$ "
PATH="/Library/PostgreSQL/9.3/bin:/usr/local/bin:${PATH}"
export CLICOLOR
export LSCOLORS
export PATH
export ARCHFLAGS="-arch x86_64 -arch i386 -Wno-error=unused-command-line-argument-hard-error-in-future" # For compilation under Mavericks.
export C_INCLUDE_PATH="/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.9.sdk/usr/include/libxml2/:${C_INCLUDE_PATH}"
export SVN_EDITOR=vim

#PATH="/Users/michiel/source/Android/android-sdk-macosx/platform-tools:${PATH}"
#export PATH
