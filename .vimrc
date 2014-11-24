execute pathogen#infect()
syntax on
filetype plugin indent on

set nocompatible

" Backups {{{
if v:version >= 703
    set undofile
    set undodir=./.tmp,/tmp
else
    let g:gundo_disable = 1
endif
set backupdir=./.tmp,.,/tmp
set directory=./.tmp,/tmp
set history=500
set undolevels=500

" appearance options
set t_Co=256
colorscheme molokai

set guifont=Inconsolota-dz\ for\ Powerline
let g:Powerline_symbols = 'fancy'
let g:airline_powerline_fonts = 1

" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1
" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'

function! WinMove(key) 
      let t:curwin = winnr()
        exec "wincmd ".a:key
          if (t:curwin == winnr()) "we havent moved
                  if (match(a:key,'[jk]')) "were we going up/down
                            wincmd v
                                else 
                                          wincmd s
                                              endif
                                                  exec "wincmd ".a:key
                                                    endif
                                                endfunction

noremap <C-J> :call WinMove('j')<cr>
noremap <C-K> :call WinMove('k')<cr>
noremap <C-L> <:call WinMove('l')<cr>
noremap <C-H> <:call WinMove('h')<cr>

" Security
set modelines=0

" Tabs/spaces
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

" Special filetype conf
au FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

" Basic options
set encoding=utf-8
set scrolloff=3
set autoindent
set showmode
set showcmd
set hidden
set wildmenu
set wildmode=list:longest
set visualbell
set cursorline
set ttyfast
set ruler
set backspace=indent,eol,start
set laststatus=2
set number
set pastetoggle=<F2>

set mouse=a

" Leader
let mapleader = ","

" Searching
nnoremap / /\v
vnoremap / /\v
set ignorecase
set smartcase
set incsearch
set showmatch
set hlsearch
set gdefault

" Disable highlight
map <leader><space> :noh<cr>:call clearmatches()<cr>
runtime macros/matchit.vim
nmap <tab> %
vmap <tab> %

" Soft/hard wrapping
set wrap
set textwidth=79
set formatoptions=qrn1

" Use the same symbols as TextMate for tabstops and EOLs
set list
set listchars=tab:▸\
