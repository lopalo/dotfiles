if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

set rtp+=~/.vim

call plug#begin('~/.vim/plugged')

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'jonathanfilip/vim-lucius'
Plug 'ervandew/supertab'
Plug 'luochen1990/rainbow'
Plug 'w0rp/ale'
Plug 'scrooloose/nerdtree'
Plug 'kien/ctrlp.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-obsession'
Plug 'sbdchd/neoformat'
Plug 'jpalardy/vim-slime'

Plug 'Vimjas/vim-python-pep8-indent'
Plug 'davidhalter/jedi-vim'


call plug#end()
":PlugInstall


set nocompatible                       "use Vim settings, rather than Vi settings
set incsearch                          "do incremental searching
set expandtab                          "enter spaces when tab is pressed
set textwidth=1200                     "break lines when line length increases
set autoindent                         "copy indent from current line when starting a new line
set backspace=indent,eol,start         "make backspaces more powerfull
autocmd BufWritePre * :%s/\s\+$//e     "remove trailing spaces

"visual
colorscheme lucius
LuciusDarkLowContrast
highlight Normal ctermbg=black
set cursorline                               "line cursor
set number                                   "show line numbers
syntax on                                    "syntax highlighting
set showcmd                                  "show (partial) command in status line
set colorcolumn=82                           "marker

"enable the mouse.
"if has('mouse')
"    set mouse=a
"endif

"sets how many lines of history VIM has to remember
set history=700

"enable filetype plugins
filetype plugin on
filetype indent on

"make these commonly mistyped commands still work
command! WQ wq
command! Wq wq
command! Wqa wqa
command! W w
command! Q q

"use // to search selected text in visual mode
vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>

"use :C to clear hlsearch
command! C nohlsearch

"use K in command mode to split line
nnoremap K i<CR><Esc>

let mapleader="["
let maplocalleader="["

"set to auto read when a file is changed from the outside
set autoread

"ignore case when searching
set ignorecase

"case-insensitive filename completion
set wildignorecase

"ignore these file extensions
set wildignore +=*.pyc,*.o,*.hi,*.jpg,*.png,node_modules
let g:netrw_list_hide = "\.pyc$,\.o$,\.hi$,\.jpg$,\.png$"

"when searching try to be smart about cases
set smartcase

"highlight search results
set hlsearch

"show matching brackets when text indicator is over them
set showmatch

"statusline settings
set laststatus=2
let g:airline_theme='bubblegum'

"no swap of files
set nobackup
set nowritebackup
set noswapfile

"enable to enter commands using russian layout
"set langmap=йцукенгшщзхъфывапролджэячсмитью/ЙЦУКЕHГШЩЗХЪФЫВАПРОЛДЖЭЯЧСМИТЬЮ/;qwertyuiop[]asdfghjkl;'zxcvbnm./QWERTYUIOP[]ASDFGHJKL:'ZXCVBNM./

let g:AutoPairs = {'(':')', '[':']', '{':'}','"':'"', '```':'```', '"""':'"""', "'''":"'''"}

"path to a file that is generated by *-ctags command
set tags=.ctags

let g:ale_set_highlights = 0
nmap <silent> <leader>e :ALEToggle<CR>
nmap <silent> <C-j> <Plug>(ale_next_wrap)
nmap <silent> <C-k> <Plug>(ale_previous_wrap)

noremap == :Neoformat<CR>

let g:rainbow_active = 1

let g:rainbow_conf = {
\    'ctermfgs': ['brown', 'darkblue', 184, 209, 140, 178, 'darkgreen', 'darkcyan', 52, 'darkmagenta', 125],
\    'operators': '_,_',
\    'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
\}


let g:slime_target = "tmux"


"use project-specific .vimrc files
set exrc
set secure


"language-specific settings


let g:ale_linters = {
\    'python': ['pyflakes', 'mypy'],
\    'rust': ['analyzer'],
\}


"##### Python #####


let g:neoformat_enabled_python = ['black']

autocmd FileType python nnoremap <leader>c :call MypyStrictCheck()<CR>
autocmd FileType python nnoremap <leader>C :call MypyNonStrictCheck()<CR>
"Install 'pynvim' to use jedi-vim from a virtualenv
let g:jedi#goto_command = "<leader>d"
let g:jedi#goto_assignments_command = "<leader>g"
let g:jedi#goto_stubs_command = "<leader>s"
let g:jedi#usages_command = "<leader>n"
let g:jedi#rename_command = "<leader>r"
let g:jedi#documentation_command = "<leader>h"
let g:jedi#popup_on_dot = 0
let g:jedi#show_call_signatures = "2"

let g:ale_python_mypy_options = ""
function MypyStrictCheck()
    let g:ale_python_mypy_options = "--strict"
    :call ale#Queue(0, 'lint_file')
endfunction

function MypyNonStrictCheck()
    let g:ale_python_mypy_options = ""
    :call ale#Queue(0, 'lint_file')
endfunction


"##### Rust #####


let g:neoformat_enabled_rust = ['rustfmt']
let g:ale_completion_enabled = 1

"Install 'rust-analyzer'
"Run 'rustup component add rust-src' to add the source code of Rust's std library
autocmd FileType rust nnoremap <leader>d :ALEGoToDefinition<CR>
autocmd FileType rust nnoremap <leader>n :ALEFindReferences<CR>
autocmd FileType rust nnoremap <leader>r :ALERename<CR>
autocmd FileType rust nnoremap <leader>h :ALEHover<CR>



