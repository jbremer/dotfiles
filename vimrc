set nocompatible              " be iMproved, required
filetype off                  " required

" https://github.com/numirias/security/blob/master/doc/2019-06-04_ace-vim-neovim.md
set nomodeline

" ensure the flake8 module is used and it is being ran without having to
" update the $PATH with anything special
let g:syntastic_python_flake8_exe = 'python -m flake8.run'

" ignore error about not using whitespace around certain operators
let g:syntastic_python_flake8_args = '--ignore=E226,E302,E501'

" https://realpython.com/blog/python/vim-and-python-a-match-made-in-heaven/
let g:ycm_autoclose_preview_window_after_completion=1
let g:ycm_python_binary_path = '/usr/bin/python'

" Python mode checkers
" let g:pymode_lint_checkers = ['pylint', 'pep8', 'mccabe', 'pep257', 'pyflakes']
" let g:pymode_lint_ignore = ''

" Following shortcuts are taken from
" http://sheerun.net/2014/03/21/how-to-boost-your-vim-productivity/

" let mapleader = "\<Space>"

" pydoc path for python_pydoc.vim
let g:pydoc_cmd = 'python -m pydoc'

" add php to the MatchTagAlways list
let g:mta_filetypes = {'html': 1, 'xhtml': 1, 'xml': 1, 'jinja': 1, 'php': 1}

let g:ycm_confirm_extra_conf = 0

" 1mb files are considered big
let g:LargeFile = 1

" https://github.com/fatih/vim-go-tutorial
let g:go_auto_type_info = 1
let g:go_auto_sameids = 1
set updatetime=100

" ignore file extensions in NERDTree
let NERDTreeIgnore=['\.pyc$', '\~$']

" Force .md as markdown
autocmd BufNewFile,BufReadPost *.md set filetype=markdown

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'                  " Vundle
" Plugin 'wincent/command-t'                  " <leader>t file browser
" Plugin 'jnurmine/Zenburn'                   " Colorscheme
" Plugin 'Valloric/YouCompleteMe'             " C/C++ auto-completion
Plugin 'scrooloose/nerdtree'                " NERD Tree file browser
Plugin 'scrooloose/syntastic'               " Static syntax checker
" Plugin 'vim-scripts/gitignore'              " Turn .gitignore into vim ignore
Plugin 'tpope/vim-surround'                 " cs'\" etc
" Plugin 'tpope/vim-repeat'                   " Use . on some more stuff
" Plugin 'sjl/splice.vim'                     " Splice mergetool
" Plugin 'tpope/vim-speeddating'              " ^A and ^X on dates
" Plugin 'bogado/file-line'                   " Open a.py:42
" Plugin 'xolox/vim-misc'                     " Required for vim-easytags
" Plugin 'xolox/vim-easytags'                 " ctags wrapper
" Plugin 'klen/python-mode'                 " Python enhancements
" Plugin 'nathanaelkane/vim-indent-guides'  " Highlights indents
" Plugin 'LargeFile'                          " Large file support
Plugin 'bling/vim-airline'                  " Status bar
" Plugin 'majutsushi/tagbar'                " Display ctags information
" Plugin 'justinmk/vim-sneak'                 " Sneak motion thing (fab)
" Plugin 'tyru/open-browser.vim'              " Open URL in browser (gx)
" Plugin 'tommcdo/vim-exchange'               " Exchange two words or lines (cx)
Plugin 'vim-scripts/a.vim'                  " Open src/inc files
Plugin 'hynek/vim-python-pep8-indent'       " PEP8 indentation
" Plugin 'terryma/vim-expand-region'          " region expanding, see further below
" Plugin 'SirVer/ultisnips'                   " required for youcompleteme
Plugin 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
filetype plugin on

" enable syntax highlighting
let python_highlight_all=1
syntax on

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
" set number              " set line numbers
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
set fileformats=unix,mac

set cc=80               " colorcolumn 80

" http://stevelosh.com/blog/2010/09/coming-home-to-vim
" nnoremap / /\v
" vnoremap / /\v

" editor layout
set termencoding=utf-8
set encoding=utf-8

set history=1000        " remember more commands and search history
set undolevels=1000     " remember more undo levels

set nobackup            " dont use backup files
set noswapfile          " dont use a swap file

set wildmenu            " bash-alike tab-completion
set wildmode=list:full   " show a list when pressing tab
 " blacklisted file extensions
set wildignore=*.o,*.tar.gz,*.tgz,*.exe,*.pyc,*.class

set novisualbell          " dont beep
set noerrorbells        " dont beep

" make the current line bold
set cursorline
highlight CursorLine cterm=bold

" nnoremap ';' to ':' for more awesomeness!
" nnoremap ; :

map! <F1> <ESC>         " we dont want to accidently press F1

nmap Y y$           " yank to the end of the line

" yank/paste to/from the OS clipboard with ,y and ,p
nmap <leader>y "+y
nmap <leader>Y "+yy
vmap <leader>y "+y
vmap <leader>Y "+yy
nmap <leader>p "+p
nmap <leader>P "+pp

" whitelist of filetypes that should be stripped when saving
let s:whitelist = ['c', 'cpp', 'python', 'tex', 'markdown', 'text', 'rst', 'sh', 'dosini', 'dosbatch', 'asm', 'go']
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
" colorscheme zenburn

" don't go to the beginning of the line when inserting a hash (#) token
" inoremap # X<C-H>#

" list all available files in the current directory for editing
" map <leader>e :e <C-R>=expand("%:p:h")."/"<CR><CR>

if has("gui_win32")
    set guioptions -=m  " remove menu bar
    set guioptions -=T  " remove toolbar
    set guioptions -=r  " remove right-hand scroll bar
    set guioptions -=R  " remove right-hand scroll bar
    set guioptions -=l  " remove left-hand scroll bar
    set guioptions -=L  " remove left-hand scroll bar
    set guioptions -=b  " remove bottom scroll bar
endif

" nnoremap <C-q> :call <SID>QuickfixToggle()<cr>

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

" ,w saves the current file
" nnoremap <leader>w :w<CR>
" nnoremap <leader>W :w!<CR>

" ,q quickly quits the current buffer / window
" ,Q quickly quits the current possibly unsaved buffer / window
" nnoremap <leader>q :q<CR>
" nnoremap <leader>Q :q!<CR>

" go from insert mode to normal mode using jj
inoremap jj <Esc>

" visual mode shift without loosing selection
vmap < <gv
vmap > >gv

" <leader>s toggles between .h and .c file, shortcut for a.vim
" o for open in current window
" s for open in new split
" v for open in new vsplit
" split with the html representation of this buffer
nmap <leader>so :A<CR>
nmap <leader>ss :AS<CR>
nmap <leader>sv :AV<CR>
nmap <leader>sh :TOhtml<CR>

" <leader>m opens the Makefile in a split
" nmap <leader>m :sp Makefile<CR>

" :update saves only if there were changes
nnoremap <F5> :update<CR>:silent !make<CR>
inoremap <F5> <ESC>:update<CR>:silent !make<CR>

nmap <leader>i :GoImports<CR>

" set spell checking on
set spell
set spelllang=en
" set nospell

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

function! NoSpell()
    setlocal nospell
endfunction

" change between no spelling checks, english, and dutch
nmap <silent> <F7> :call ToggleSpell()<CR>
nmap <silent> <F8> :call NoSpell()<CR>

" toggle paste mode
let g:paste_mode = 0

function! TogglePaste()
    if g:paste_mode == 0
        set paste
        let g:paste_mode = 1
    else
        set nopaste
        let g:paste_mode = 0
    endif
endfunction

nmap <silent> <F12> :call TogglePaste()<CR>

" toggle nerd tree
nmap <silent> <C-n> :NERDTreeToggle<CR>

" html and rst stuff
if &ft == 'htmldjango' || &ft == 'rst'
    set shiftwidth=2
endif

" goto implementation or declaration
" nnoremap <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>

" toggle the tagbar (ctags stuff)
" nnoremap <silent> <C-M> :TagbarToggle<CR>

" use f{char}{char} to search for the next occurrence of {char}{char}
" replaces original f meaning
" nmap f <Plug>Sneak_s
" nmap F <Plug>Sneak_S
" xmap f <Plug>Sneak_s
" xmap F <Plug>Sneak_S
" omap f <Plug>Sneak_s
" omap F <Plug>Sneak_S

" open word or url in browser with gx
" let g:netrw_nogx = 1 " disable netrw's gx mapping.
" nmap gx <Plug>(openbrowser-smart-search)
" vmap gx <Plug>(openbrowser-smart-search)

" always show the status line by airline
set laststatus=2

" Following shortcuts are taken from
" http://sheerun.net/2014/03/21/how-to-boost-your-vim-productivity/

" Hit v to select one character
" Hit v again to expand selection to word
" Hit v again to expand to paragraph
" ...
" Hit <C-v> go back to previous selection if I went too far
" vmap v <Plug>(expand_region_expand)
" vmap <C-v> <Plug>(expand_region_shrink)

" search things usual way using /something
" hit cs, replace first match, and hit <Esc>
" hit n.n.n.n.n. reviewing and replacing all matches
" vnoremap <silent> s //e<C-r>=&selection=='exclusive'?'+1':''<CR><CR>
    " \:<C-u>call histdel('search',-1)<Bar>let @/=histget('search',-1)<CR>gv
" omap s :normal vs<CR>

" automatically jump to end of text you pasted
vnoremap <silent> y y`]
vnoremap <silent> p p`]
nnoremap <silent> p p`]

" only use files defined by Git in ctrlp
" let g:ctrlp_use_caching = 0
" if executable('ag')
"     set grepprg=ag\ --nogroup\ --nocolor
"
"     let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
" else
"   let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']
"   let g:ctrlp_prompt_mappings = {
"     \ 'AcceptSelection("e")': ['<space>', '<cr>', '<2-LeftMouse>'],
"     \ }
" endif

" Open NERDTree when Vim starts up and no files were specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" disable autocomplete by default
let g:acp_EnableAtStartup = 0

let g:go_def_mode='gopls'
let g:go_info_mode='gopls'
