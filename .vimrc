"packages to install:
"    exuberant-ctags
"    es-ctags

"linters to install:
"    Python: pylint
"    Haskell: ghc_mod, hlint
"    JavaScript: eslint
"    Clojure ClojureScript: joker
"    OCaml: merlin

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
Plug 'vim-syntastic/syntastic'
Plug 'w0rp/ale'
Plug 'scrooloose/nerdtree'
Plug 'kien/ctrlp.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-obsession'
Plug 'sbdchd/neoformat'
Plug 'jpalardy/vim-slime'

Plug 'tpope/vim-fireplace'
Plug 'venantius/vim-cljfmt'
Plug 'bhurlow/vim-parinfer'

call plug#end()
":PlugInstall


set nocompatible                       "use Vim settings, rather than Vi settings
set incsearch                          "do incremental searching
set expandtab                          "enter spaces when tab is pressed
set textwidth=1200                     "break lines when line length increases
set tabstop=4                          "use 4 spaces to represent tab
set softtabstop=4
set shiftwidth=4                       "number of spaces to use for auto indent
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

let maplocalleader="\<space>"

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

let g:syntastic_mode_map = {'mode': 'passive'}

let g:ale_set_highlights = 0
nmap <silent> <LocalLeader>e :ALEToggle<CR>
nmap <silent> <C-j> <Plug>(ale_next_wrap)
nmap <silent> <C-k> <Plug>(ale_previous_wrap)

let g:rainbow_active = 1

let g:rainbow_conf = {
\   'ctermfgs': ['brown', 'darkblue', 184, 209, 140, 178, 'darkgreen', 'darkcyan', 52, 'darkmagenta', 125],
\   'operators': '_,_',
\   'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
\}

let g:vim_parinfer_globs = ['*.clj', '*.cljs', '*.cljc', '*.edn', '*.jly', 'dune', 'dune-project', 'dune-workspace']

let g:slime_target = "tmux"

noremap == :Neoformat<CR>

"use project specific .vimrc files
set exrc
set secure

"##### Clojure #####
"reload namespace in Clojure REPL
autocmd BufWritePost *.clj,*.cljc :Require
autocmd FileType clojure nnoremap <buffer> >> :call parinfer#do_indent()<CR>
autocmd FileType clojure nnoremap <buffer> << :call parinfer#do_undent()<CR>
autocmd FileType clojure nnoremap mm :Eval (intern 'user 'm *1)<CR>

let g:clj_fmt_autosave = 0

"##### Jelly #####
autocmd BufNewFile,BufRead *.jly set ft=scheme
autocmd BufNewFile,BufRead *.jly setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2


"##### Ocaml #####
autocmd Filetype ocaml setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
autocmd FileType ocaml nnoremap [d :MerlinLocate<CR>
autocmd FileType ocaml nnoremap <LocalLeader>d :MerlinDocument<CR>

let g:neoformat_enabled_ocaml = ['ocamlformat']

let g:opamshare = substitute(system('opam config var share'), '\n$', '', '''')
execute "set rtp+=" . g:opamshare . "/merlin/vim"

