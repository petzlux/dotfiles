execute pathogen#infect()
syntax on
filetype plugin indent on

set nocompatible

" Leader
" let mapleader = ","
let mapleader = "\<Space>"

" leader shortcuts 
" stuff from http://sheerun.net/2014/03/21/how-to-boost-your-vim-productivity/
nnoremap <Leader>p :CtrlPMixed<CR>
nnoremap <Leader>w :w<CR>
nnoremap <Leader>b :bd<CR>
nnoremap <Leader>e :e<CR>
nmap <Leader>v V

" use tab to match and navigate between brackets
nnoremap <tab> %
vnoremap <tab> %

" Automatically jump to end of text you pasted:
" I can paste multiple lines multiple times with simple ppppp.
vnoremap <silent> y y`]
vnoremap <silent> p p`]
nnoremap <silent> p p`]

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

" Special filetype indentationindentation conf
au FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
au FileType python setlocal ts=4 sts=4 sw=4 expandtab
au FileType javascript setlocal ts=2 sts=2 sw=2 expandtab
au FileType html setlocal ts=2 sts=2 sw=2 expandtab
au FileType css setlocal ts=2 sts=2 sw=2 expandtab

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

" Searching
nnoremap / /\v
vnoremap / /\v
set ignorecase
set smartcase
set incsearch
set showmatch
set hlsearch
set gdefault
"This unsets the "last search pattern" register by hitting return
nnoremap <CR> :noh<CR><CR>

" Soft/hard wrapping
set wrap
set list
set textwidth=79
set colorcolumn=85
set formatoptions=qrn1

" folding options
set foldmethod=syntax
set foldlevelstart=99
vnoremap <Leader>f zf

" Ctrlp plugin set to search all files, buffers and history
let g:ctrlp_cmd = 'CtrlPMixed'

" Use the same symbols as TextMate for tabstops and EOLs
set list
set listchars=tab:▸\ ,eol:¬

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
":python << EOF
"import os
"virtualenv = os.environ.get('VIRTUAL_ENV')
"if virtualenv:
"    activate_this = os.path.join(virtualenv, 'bin', 'activate_this.py')
"    if os.path.exists(activate_this):
"        execfile(activate_this, dict(__file__=activate_this))
"EOF

" conoline plugin autoactivate for current line hightlight
let g:conoline_auto_enable = 1
" Use colors defined by colorscheme in normal mode.
let g:conoline_use_colorscheme_default_normal = 1
" Use colors defined by colorscheme in insert mode.
let g:conoline_use_colorscheme_default_insert = 1

" syntastic syntax checker config 
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" toggle error window with ctrl e
function! ToggleErrors()
    if empty(filter(tabpagebuflist(), 'getbufvar(v:val, "&buftype") is# "quickfix"'))
         " No location/quickfix list shown, open syntastic error location panel
         Errors
    else
        lclose
    endif
endfunction
nnoremap <silent> <C-e> :<C-u>call ToggleErrors()<CR>

let g:syntastic_mode_map = { 'mode': 'active',
    \ 'active_filetypes': [],
    \ 'passive_filetypes': ['html'] }
let g:syntastic_javascript_closurecompiler_path = '~/.dotfiles/.vim/closure_compiler/compiler.jar'
let g:syntastic_javascript_checkers = ["gjslint"]
let g:syntastic_gjslint_conf = " --jslint_error=all --strict --custom_jsdoc_tags=event,fires,function,classdesc,api,observable "
let g:syntastic_python_checkers = ["flake8", "pep8"]

" GitGutter config
let g:gitgutter_realtime = 1
let g:gitgutter_eager = 1
let g:gitgutter_updatetime = 750
nmap <leader>ha <Plug>GitGutterStageHunk
nmap <leader>hu <Plug>GGitGutterRevertHunk
nmap <leader>hp <Plug>GitGutterPreviewHunk

" automatically close preview window
autocmd CursorHold *  if pumvisible() == 0|silent! pclose|endif
autocmd InsertLeave * if pumvisible() == 0|silent! pclose|endif

" expand region plugin mapping
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

" use git to search for files for Ctrl P
" http://sheerun.net/2014/03/21/how-to-boost-your-vim-productivity/
let g:ctrlp_use_caching = 0
if executable('ag')
    set grepprg=ag\ --nogroup\ --nocolor

    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
else
  let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']
  let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("e")': ['<space>', '<cr>', '<2-LeftMouse>'],
    \ }
endif

" vp doesn't replace paste buffer
" http://sheerun.net/2014/03/21/how-to-boost-your-vim-productivity/
function! RestoreRegister()
  let @" = s:restore_reg
  return ''
endfunction
function! s:Repl()
  let s:restore_reg = @"
  return "p@=RestoreRegister()\<cr>"
endfunction
vmap <silent> <expr> p <sid>Repl()
