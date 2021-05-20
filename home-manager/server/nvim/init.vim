" TODO: Check mjlbachs sane template!

" Autostart
" autocmd VimEnter * RainbowParentheses

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
" lua <<EOF
" local remap = vim.api.nvim_set_keymap
" local npairs = require('nvim-autopairs')

" -- skip it, if you use another global object
" _G.MUtils= {}

" vim.g.completion_confirm_key = ""
" MUtils.completion_confirm=function()
"   if vim.fn.pumvisible() ~= 0  then
"     if vim.fn.complete_info()["selected"] ~= -1 then
"       return vim.fn["compe#confirm"](npairs.esc("<cr>"))
"     else
"       return npairs.esc("<cr>")
"     end
"   else
"     return npairs.autopairs_cr()
"   end
" end

" remap('i' , '<CR>','v:lua.MUtils.completion_confirm()', {expr = true , noremap = true})
" require('nvim-autopairs').setup()
" EOF
