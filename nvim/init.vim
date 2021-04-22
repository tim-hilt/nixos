" Autostart
autocmd VimEnter * RainbowParentheses

set completeopt=menu,menuone,noselect
syntax on 
set noswapfile
set number 
set splitbelow
set splitright
set autochdir
set hlsearch 
set ignorecase
set noshowmode
set incsearch
set pyxversion=3

" Indentation
set tabstop=4
set expandtab
set shiftwidth=2
set autoindent
set smartindent
set cindent

" Keymaps
inoremap jk <ESC>
inoremap <S-CR> <ESC>o

" Misc
lua require('nvim-autopairs').setup()
