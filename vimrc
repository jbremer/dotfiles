set nocompatible        " We dont support Vi compatibility

" ensure the flake8 module is used and it is being ran without having to
" update the $PATH with anything special
let g:syntastic_python_checker = 'flake8'
let g:syntastic_python_flake8_exe = 'python -m flake8.run'

" ignore error about not using whitespace around certain operators
let g:syntastic_python_checker_args = '--ignore=E225,E226,E302,E501'

" set the leader key for splice.vim as comma
let g:splice_leader = ","

" pydoc path for python_pydoc.vim
let g:pydoc_cmd = 'python -m pydoc'

" add php to the MatchTagAlways list
let g:mta_filetypes = {'html': 1, 'xhtml': 1, 'xml': 1, 'jinja': 1, 'php': 1}

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

" make the current line bold
set cursorline
highlight CursorLine cterm=bold

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

" whitelist of filetypes that should be stripped when saving
let s:whitelist = ['c', 'cpp', 'python', 'tex', 'markdown', 'text']
let s:rewrite_buf = 1

function! s:NoRewrite()
    let s:rewrite_buf = 0
endfunction

command! -nargs=0 NoRewrite call s:NoRewrite()

" automatically convert all tabs to (four) whitespaces
au BufWrite * if index(s:whitelist, &ft) >= 0 && s:rewrite_buf | :%retab

" automatically remove all trailing whitespaces
au BufWrite * if index(s:whitelist, &ft) >= 0 && s:rewrite_buf | :%s/\s\+$//e

" set a decent colorscheme
colorscheme asu1dark

" don't go to the beginning of the line when inserting a hash (#) token
inoremap # X<C-H>#

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

" go from insert mode to normal mode using jj
inoremap jj <Esc>

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

" :update saves only if there were changes
nnoremap <F5> :update<CR>:silent !make<CR>
inoremap <F5> <ESC>:update<CR>:silent !make<CR>

" google the function under the cursor for msdn using google
nmap <leader>K :silent !cmd /c start http://google.com/search?q=msdn+<C-R><C-W><CR>

" set spell checking on
set spell
set spelllang=en

" Spell Check
let g:spell_curlang = 0
let g:spell_langlist = ["nospell", "nl", "en"]

function! ToggleSpell()
    let g:spell_curlang = g:spell_curlang + 1
    if g:spell_curlang >= len(g:spell_langlist)
        let g:spell_curlang = 0
    endif
    if g:spell_curlang == 0
        setlocal nospell
    else
        let s:curlang = g:spell_langlist[g:spell_curlang]
        execute "setlocal spell spelllang=".s:curlang
    endif
    echo "spell checking language:" g:spell_langlist[g:spell_curlang]
endfunction

nmap <silent> <F7> :call ToggleSpell()<CR>

" toggle nerd tree
nmap <C-n> :NERDTreeToggle<CR>

" html stuff
if &ft == 'htmldjango'
    set shiftwidth=2
endif
