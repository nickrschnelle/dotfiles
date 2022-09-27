" https://www.atlassian.com/git/tutorials/dotfiles
let mapleader = " "
inoremap jk <esc>
nnoremap <leader>fl :Files<CR>
nnoremap <leader>gfl :GFiles<CR>
nnoremap <leader>el :Ex<CR>
set encoding=UTF-8
set autoread
set nocompatible
set number
set noswapfile
set hlsearch
set ignorecase
set incsearch
filetype plugin indent on
set expandtab
set tabstop=2
set softtabstop=2
set smartindent
set shiftwidth=2
set scrolloff=5
set laststatus=2
set relativenumber
set signcolumn=yes
set nu
set nowrap
set hidden

let g:lightline = {
      \ 'colorscheme': 'one',
      \ }
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
let g:fzf_layout = { 'window': { 'width': 0.95, 'height': 0.95 } }

let @c = "oconsole.log('',);jkhhhh\"0pll\"0p'"
let @l = "yiwoconsole.log('',);jkhhhh\"0pll\"0p'"

call plug#begin()
Plug 'yuezk/vim-js'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'itchyny/lightline.vim'
Plug 'mattn/emmet-vim'
Plug 'https://github.com/tpope/vim-fugitive'
Plug 'joshdick/onedark.vim'
Plug 'sheerun/vim-polyglot'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'jiangmiao/auto-pairs'
Plug 'wellle/context.vim'
Plug 'ryanoasis/vim-devicons'
Plug 'https://github.com/airblade/vim-rooter.git'
Plug 'vim-syntastic/syntastic'
call plug#end()

"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif
let g:onedark_termcolors=256
syntax on
set re=0
colorscheme onedark
