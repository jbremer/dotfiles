set nocompatible        " We dont support Vi compatibility

" ensure the flake8 module is used and it is being ran without having to
" update the $PATH with anything special
let g:syntastic_python_checker = 'flake8'
let g:syntastic_python_flake8_exe = 'python -m flake8.run'

" set the leader key for splice.vim as comma
let g:splice_leader = ","

" pydoc path for python_pydoc.vim
let g:pydoc_cmd = 'python -m pydoc'

" force reloading after pathogen has loaded
filetype off
call pathogen#infect()
call pathogen#helptags()

" enable indentation
filetype plugin indent on

" enable syntax highlighting
syntax on

let mapleader=","       " change mapleader

set showmode            " show which mode we are currently in
set nowrap              " dont wrap lines
set tabstop=4           " a tab equals four spaces
set softtabstop=4       " deletes tab instead of a space
set expandtab           " automatically expand tabs
set shiftwidth=4        " number of spaces used for autoindent
set shiftround          " use multiple shiftwidth for '<' and '>'
set backspace=indent,eol,start  " allow backspace over anything in insert mode
set autoindent          " automatically indent
set copyindent          " copy the current indentation on indent
set number              " set line numbers
set showmatch           " set show matching parenthesis
set ignorecase          " ignore case when searching
set smartcase           " search case-sensitive for mixalpha queries
set smarttab            " not sure?
set smartindent         " automatically indent
set scrolloff=16        " keep 8 lines off the edges when scrolling
set virtualedit=all     " allow the cursor to go in 'invalid' places
set hlsearch            " highlight search terms
set incsearch           " incremental search, search as you type
set gdefault            " search/replace 'globally' (on a line) by
                        " default
set nolist              " dont show invisible characters by default
set pastetoggle=<F2>    " toggle paste mode
set mouse=a             " enable the mouse, if terminal supports that
set fileformat=unix
set fileformats=unix,dos,mac

set cc=80               " colorcolumn 80

" clear out search result highlights
nnoremap <space> :noh<CR>

" http://stevelosh.com/blog/2010/09/coming-home-to-vim
nnoremap / /\v
vnoremap / /\v

" editor layout
set termencoding=utf-8
set encoding=utf-8

set history=1000        " remember more commands and search history
set undolevels=1000     " remember more undo levels

set nobackup            " dont use backup files
set noswapfile          " dont use a swap file

set wildmenu            " bash-alike tab-completion
set wildmode=list:full      " show a list when pressing tab
set wildignore=*.pyc,*.class    " blacklisted file extensions

set visualbell          " dont beep
set noerrorbells        " dont beep

" set cursorline        " underline the current line

" remap ';' to ':' for more awesomeness!
nnoremap ; :

map! <F1> <ESC>         " we dont want to accidently press F1

nnoremap <leader>w <C-w>v<C-w>l " duplicate the current window

nmap Y y$           " yank to the end of the line

" yank/paste to/from the OS clipboard with ,y and ,p
nmap <leader>y "+y
nmap <leader>Y "+yy
vmap <leader>y "+y
vmap <leader>Y "+yy
nmap <leader>p "+p
nmap <leader>P "+pp

" automatically convert all tabs to (four) whitespaces
au BufWrite * :%retab

" automatically remove all trailing whitespaces
au BufWrite * :%s/\s\+$//e

" set a decent colorscheme
colorscheme asu1dark

" don't go to the beginning of the line when inserting a hash (#) token
inoremap # X<C-H>#

" full go support
if has("win32")
    set rtp+=C:/Go/misc/vim
endif

" list all available files in the current directory for editing
map <leader>e :e <C-R>=expand("%:p:h")."/"<CR><CR>

if has("gui_win32")
    set guioptions -=m  " remove menu bar
    set guioptions -=T  " remove toolbar
    set guioptions -=r  " remove right-hand scroll bar
    set guioptions -=R  " remove right-hand scroll bar
    set guioptions -=l  " remove left-hand scroll bar
    set guioptions -=L  " remove left-hand scroll bar
    set guioptions -=b  " remove bottom scroll bar
endif

nnoremap <C-q> :call <SID>QuickfixToggle()<cr>

let g:quickfix_is_open = 0

function! s:QuickfixToggle()
    if g:quickfix_is_open
        cclose
        let g:quickfix_is_open = 0
        execute g:quickfix_return_to_window . "wincmd w"
    else
        let g:quickfix_return_to_window = winnr()
        copen
        let g:quickfix_is_open = 1
    endif
endfunction

" ,q quickly quits the current buffer / window
" ,Q quickly quits the current possibly unsaved buffer / window
nnoremap <leader>q :q<CR>
nnoremap <leader>Q :q!<CR>

" go from insert mode to normal mode using jj or kk
inoremap jj <Esc>
inoremap kk <Esc>

" visual mode shift without loosing selection
vmap < <gv
vmap > >gv

" <leader>t toggles between .h and .c file, shortcut for a.vim
" o for open in current window
" s for open in new split
" v for open in new vsplit
" split with the html representation of this buffer
nmap <leader>to :A<CR>
nmap <leader>ts :AS<CR>
nmap <leader>tv :AV<CR>
nmap <leader>th :TOhtml<CR>

" <leader>m opens the Makefile in a split
nmap <leader>m :sp Makefile<CR>

nnoremap <F5> :w<CR>:silent !make<CR>
inoremap <F5> <ESC>:w<CR>:silent !make<CR>
