syntax on

set noerrorbells
set belloff=all
set tabstop=4 softtabstop=4
set shiftwidth=4
:" set tabstop=2 softtabstop=2
" set shiftwidth=2

set mouse=a
map <ScrollWheelUp> <C-Y>
map <ScrollWheelDown> <C-E>

set expandtab
set smartindent
set number
set smartcase
set hlsearch

set path+=**
" set wildmenu
" set wildoptions=fuzzy
set wildchar=<tab>
set ignorecase
set wildignore=*.pyc

" set formatoptions-=cro
" set paste
au FileType * set fo-=c fo-=r fo-=o

call plug#begin('~/.vim/plugged')

" themes
Plug 'morhetz/gruvbox'
Plug 'ErichDonGubler/vim-sublime-monokai'
Plug 'tomasiser/vim-code-dark'
Plug 'joshdick/onedark.vim'
Plug 'altercation/vim-colors-solarized'

" look
Plug 'itchyny/lightline.vim'
Plug 'edkolev/tmuxline.vim'

" utils
" Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-commentary'
Plug 'preservim/nerdtree'

" completion
" Plug 'ycm-core/YouCompleteMe'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

" wilder
if has('nvim')
  function! UpdateRemotePlugins(...)
    " Needed to refresh runtime files
    let &rtp=&rtp
    UpdateRemotePlugins
  endfunction

  Plug 'gelguy/wilder.nvim', { 'do': function('UpdateRemotePlugins') }
else
  Plug 'gelguy/wilder.nvim'

  " To use Python remote plugin features in Vim, can be skipped
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif

" coc
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'sheerun/vim-polyglot'

call plug#end()

" colorscheme
colorscheme solarized
" colorscheme onedark
set background=dark

" background
highlight VertSplit cterm=None ctermfg=12 ctermbg=NONE
highlight SignColumn ctermbg=NONE

" YouCompleteMe
" set backspace=indent,eol,start

" lightline
let g:lightline = { 'colorscheme': 'materia' }
set laststatus=2
set noshowmode

" Tmuxline
" Tmuxline lightline

" NERDTree
let g:NERDTreeHijackNetrw=0

" set termwinsize=10x0
" coc
source ~/.vim/coc.vim

" wilder
" call wilder#setup({'modes': [':', '/', '?']})

" keymapping
silent! nmap <M-b> :NERDTreeToggle<CR>
silent! nmap <M-p> :find<space>
silent! nmap <A-F> :call CocAction('format')<CR>
silent! nmap <M-a> :Commentary<CR>
silent! vmap <M-a> :Commentary<CR>
