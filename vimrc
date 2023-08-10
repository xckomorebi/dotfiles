" syntax on

set noerrorbells
set belloff=all
set tabstop=4
set softtabstop=4
set shiftwidth=4
<<<<<<< HEAD
=======
" set tabstop=2 softtabstop=2
" set shiftwidth=2
>>>>>>> 3ea9371 (new branch for archlinux)

set mouse=a
map <ScrollWheelUp> <C-Y>
map <ScrollWheelDown> <C-E>

set expandtab
set smartindent
set number
set smartcase
set hlsearch

" set path+=**
" set wildchar=<tab>
" set ignorecase
" set wildignore=*.pyc

" set autochdir

" set formatoptions-=cro
" set paste
au FileType * set fo-=c fo-=r fo-=o

call plug#begin('~/.vim/plugged')

" themes
Plug 'sainnhe/sonokai'

" look
" Plug 'itchyny/lightline.vim'
" Plug 'edkolev/tmuxline.vim'

" utils
Plug 'tpope/vim-commentary'
Plug 'preservim/nerdtree'

" telescope
" Plug 'nvim-lua/plenary.nvim'
" Plug 'BurntSushi/ripgrep'
" Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.8' }
" Plug 'tpope/vim-fugitive'

call plug#end()

" colorscheme
" colorscheme edge
" let g:sonokai_disable_italic_comment=1
" let g:sonokai_transparent_background=1
colorscheme sonokai

" lightline
" let g:lightline = {
"             \ 'colorscheme': 'materia',
"             \ 'active': {
"             \   'left': [ [ 'mode', 'paste' ],
"             \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
"             \ },
"             \ 'component_function': {
"             \   'gitbranch': 'FugitiveHead'
"             \ },
"             \ }

set laststatus=2
set noshowmode

" commentary
autocmd FileType c setlocal commentstring=//\ %s
autocmd FileType cpp setlocal commentstring=//\ %s

" Tmuxline
" Tmuxline lightline

let mapleader=" "

" nnoremap <leader>b <cmd>NERDTreeToggle<cr>
" nnoremap <leader>r <cmd>NERDTreeFind<cr>

" wilder
" call wilder#setup({'modes': [':', '/', '?']})

" keymapping
silent! nmap <M-b> <cmd>NERDTreeToggle<CR>
silent! nmap <A-F> <cmd>call CocAction('format')<CR>

silent! nmap <M-a> <cmd>Commentary<CR>
silent! vmap <M-a> :Commentary<CR>

nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
" nnoremap <leader>fh <cmd>Telescope help_tags<cr>
