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

" Map Ctrl + HJKL to move and open new splits as needed
noremap <C-J> :call WinMove('j')<cr>
noremap <C-K> :call WinMove('k')<cr>
noremap <C-L> :call WinMove('l')<cr>
noremap <C-H> :call WinMove('h')<cr>

" Map Ctrl + a  to switch between buffers
noremap <C-a> :bnext<cr>

" autor equalise splits on window resize
autocmd VimResized * wincmd =

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

" Cange editing behaviour
set list
set listchars=tab:>.,trail:.,extends:#,nbsp:.

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
nmap <silent> ,/ :nohlsearch<CR>

" Disable highlight
map <leader><space> :noh<cr>:call clearmatches()<cr>
runtime macros/matchit.vim
nmap <tab> %
vmap <tab> %

" Soft/hard wrapping
set wrap
set textwidth=79
set formatoptions=qrn1

" Ctrlp plugin set to search all files, buffers and history
let g:ctrlp_cmd = 'CtrlPMixed'

" Use the same symbols as TextMate for tabstops and EOLs
set list
set listchars=tab:>.,trail:.,extends:#,nbsp:.

" vim-flake8 options
let g:flake8_show_quickfix=1
let g:flake8_show_in_file=1
let g:flake8_show_in_gutter=1
autocmd BufWritePost *.py call Flake8()

" Autocomplete settings for python
autocmd FileType python set omnifunc=pythoncomplete#Complete
let g:SuperTabDefaultCompletionType = "<C-X><C-O>"
let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabClosePreviewOnPopupClose = 1

" Auto paste mode when in Insert mode
let &t_SI .= "\<Esc>[?2004h"
let &t_EI .= "\<Esc>[?2004l"
inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()
function! XTermPasteBegin()
  set pastetoggle=<Esc>[201~
  set paste
  return ""
endfunction

" set virtualenvironment
:python << EOF
import os
virtualenv = os.environ.get('VIRTUAL_ENV')
if virtualenv:
    activate_this = os.path.join(virtualenv, 'bin', 'activate_this.py')
    if os.path.exists(activate_this):
        execfile(activate_this, dict(__file__=activate_this))
EOF

" conoline plugin autoactivate for current line hightlight
let g:conoline_auto_enable = 1
" Use colors defined by colorscheme in normal mode.
let g:conoline_use_colorscheme_default_normal = 1
" Use colors defined by colorscheme in insert mode.
let g:conoline_use_colorscheme_default_insert = 1
