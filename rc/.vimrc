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
autocmd! BufNewFile,BufRead *.pde setlocal ft=arduino
colorscheme koehler

set nocompatible              " be iMproved, required
" filetype off                  " required
