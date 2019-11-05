"packages to install:
"    exuberant-ctags
"    es-ctags

"linters to install:
"    Python: pylint
"    Haskell: ghc_mod, hlint
"    JavaScript: eslint
"    Clojure ClojureScript: joker
"    OCaml: merlin

"git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'jonathanfilip/vim-lucius'
Plugin 'ervandew/supertab'
Plugin 'luochen1990/rainbow'
Plugin 'vim-syntastic/syntastic'
Plugin 'w0rp/ale'
Plugin 'scrooloose/nerdtree'
Plugin 'kien/ctrlp.vim'
Plugin 'jiangmiao/auto-pairs'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-obsession'
Plugin 'sbdchd/neoformat'

Plugin 'tpope/vim-fireplace'
Plugin 'venantius/vim-cljfmt'
Plugin 'bhurlow/vim-parinfer'

call vundle#end()
":PluginInstall


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
set colorcolumn=80                           "marker


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


"path to a file that is generated by *-ctags command
set tags=.ctags

let g:syntastic_mode_map = {'mode': 'passive'}

nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

"reload namespace in Clojure REPL
autocmd BufWritePost *.clj,*.cljc :Require

let g:rainbow_active = 1

let g:rainbow_conf = {
\   'ctermfgs': ['brown', 'darkblue', 184, 209, 140, 178, 'darkgreen', 'darkcyan', 52, 'darkmagenta', 125],
\   'operators': '_,_',
\   'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
\}


let g:clj_fmt_autosave = 0


"use project specific .vimrc files
set exrc
set secure

autocmd FileType clojure nnoremap <buffer> >> :call parinfer#do_indent()<CR>
autocmd FileType clojure nnoremap <buffer> << :call parinfer#do_undent()<CR>
autocmd FileType clojure nnoremap mm :Eval (intern 'user 'm *1)<CR>

autocmd Filetype ocaml setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
autocmd FileType ocaml nnoremap [d :MerlinLocate<CR>
autocmd FileType ocaml noremap == :Neoformat<CR>

let g:neoformat_ocaml_ocamlformat = {
\   'exe': 'ocamlformat',
\   'args': ['--enable-outside-detected-project']
\}
let g:neoformat_enabled_ocaml = ['ocamlformat']
let g:vim_parinfer_globs = ['*.clj', '*.cljs', '*.cljc', '*.edn', '*.ss', 'dune', 'dune-project', 'dune-workspace']


" ## added by OPAM user-setup for vim / base ## 93ee63e278bdfc07d1139a748ed3fff2 ## you can edit, but keep this line
let s:opam_share_dir = system("opam config var share")
let s:opam_share_dir = substitute(s:opam_share_dir, '[\r\n]*$', '', '')

let s:opam_configuration = {}

function! OpamConfOcpIndent()
  execute "set rtp^=" . s:opam_share_dir . "/ocp-indent/vim"
endfunction
let s:opam_configuration['ocp-indent'] = function('OpamConfOcpIndent')

function! OpamConfOcpIndex()
  execute "set rtp+=" . s:opam_share_dir . "/ocp-index/vim"
endfunction
let s:opam_configuration['ocp-index'] = function('OpamConfOcpIndex')

function! OpamConfMerlin()
  let l:dir = s:opam_share_dir . "/merlin/vim"
  execute "set rtp+=" . l:dir
endfunction
let s:opam_configuration['merlin'] = function('OpamConfMerlin')

let s:opam_packages = ["ocp-indent", "ocp-index", "merlin"]
let s:opam_check_cmdline = ["opam list --installed --short --safe --color=never"] + s:opam_packages
let s:opam_available_tools = split(system(join(s:opam_check_cmdline)))
for tool in s:opam_packages
  " Respect package order (merlin should be after ocp-index)
  if count(s:opam_available_tools, tool) > 0
    call s:opam_configuration[tool]()
  endif
endfor
" ## end of OPAM user-setup addition for vim / base ## keep this line
