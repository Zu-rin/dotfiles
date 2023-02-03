"dein Scripts=============================
if &compatible
  set nocompatible               " Be iMproved
endif

" plugin dir path
let s:dein_dir = expand('~/dotfiles/.vim/dein')
" dein.vim dir path
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
" toml dir path
let s:toml_dir = s:dein_dir

" Required:
set runtimepath+=/home/ubuntu/dotfiles/.vim/dein/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state(s:dein_dir)
    call dein#begin(s:dein_dir)

    " plugins to load at startup
    call dein#load_toml(s:toml_dir . '/dein.toml', {'lazy': 0})
    
    " plugins to load at using
    call dein#load_toml(s:toml_dir . '/lazy.toml', {'lazy': 1})
    
    " Common plugins for neovim
    call dein#load_toml(s:toml_dir . '/share.toml', {'lazy': 0})

    " Required:
    call dein#end()
    call dein#save_state()
endif

" Required:
filetype plugin indent on

" If you want to install not installed plugins on startup.
if dein#check_install()
    call dein#install()
endif

"End dein Scripts=========================

syntax on

set shell=/usr/bin/zsh
set rtp+=/usr/bin/fzf

set t_Co=256
set t_ut=

set number
set autochdir

set encoding=utf-8
set fileencodings=utf-8,cp932

set shiftwidth=4
set tabstop=4
set expandtab

set smartindent

set hlsearch
set incsearch

set wildmenu
set wildmode=longest,full

set clipboard+=unnamed,unnamedplus

nnoremap    p   ]p
nnoremap    P   ]P

nnoremap    <S-Left>    0
nnoremap    <S-Right>   $
inoremap    <S-Left>    <C-o>0
inoremap    <S-Right>   <C-o>$

nnoremap    <C-s>   :w<Enter>
inoremap    <C-s>   <C-o><C-s>

nnoremap    <C-c>   Y
nnoremap    <C-v>   P
inoremap    <C-c>   <C-o>Y
inoremap    <C-v>   <C-o>P

nnoremap    <S-Tab>     <<
inoremap    <S-Tab>     <C-o><<

" Fern
nnoremap <C-]> :Fern . -reveal=% -drawer -toggle -width=30<CR>

" fzf
nnoremap    <silent>    fzf :Files<CR>
nnoremap    <silent>    ls  :Buffers<CR>
