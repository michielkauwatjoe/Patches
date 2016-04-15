set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set number
syntax on
filetype indent plugin on
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWritePre *.py :%s/\s\+$//e
python from powerline.vim import setup as powerline_setup
python powerline_setup()
python del powerline_setup
colorscheme koehler
set guifont=InputMono\ ExLight\ for\ Powerline:h11

set nocompatible              " be iMproved, required
" filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" " alternatively, pass a path where Vundle should install plugins
" "call vundle#begin('~/some/path/here')
"
" " let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
Bundle 'git://github.com/davidhalter/jedi-vim'
au BufRead,BufNewFile *.wf set filetype=xml
