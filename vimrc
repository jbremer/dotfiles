set nocompatible        " We dont support Vi compatibility

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
set fileformats="unix,dos,mac"

set cc=80               " colorcolumn 80

" clear out search result highlights
nnoremap <leader><space> :noh<CR>

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

" p = paste
vnoremap p <ESC>:let current_reg=@"<CR>gvdi<C-r>=current_reg<CR><ESC>

nnoremap <leader>w <C-w>v<C-w>l " duplicate the current window

nmap Y y$           " yank to the end of the line

" yank/paste to/from the OS clipboard with ,y and ,p
nmap <leader>y "+y
nmap <leader>Y "+yy
nmap <leader>p "+p
nmap <leader>P "+pp

" automatically convert all tabs to (four) whitespaces
au BufWrite *.* :%retab

" automatically remove all trailing whitespaces
au BufWrite *.* :%s/\s\+$//e

" set a decent colorscheme
colorscheme delek

" don't go to the beginning of the line when inserting a hash (#) token
inoremap # X<C-H>#