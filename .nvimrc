" Vim-Plug Section
" =================

call plug#begin()
	Plug 'morhetz/gruvbox'
	Plug 'altercation/vim-colors-solarized'

	Plug 'klen/python-mode'

    Plug 'rust-lang/rust.vim'
    Plug 'racer-rust/vim-racer'

    Plug 'cespare/vim-toml'

	Plug 'bling/vim-airline'
	Plug 'jeffkreeftmeijer/vim-numbertoggle'
	Plug 'bronson/vim-trailing-whitespace'
	Plug 'jiangmiao/auto-pairs'
	Plug 'ivanov/vim-ipython'
	Plug 'mattn/emmet-vim'
	Plug 'mattn/webapi-vim'
	Plug 'dag/vim-fish'
call plug#end()

" Standard configs
" =================

let g:racer_cmd = "/usr/local/bin/racer"
let $RUST_SRC_PATH = "/usr/local/src/rust/src/"

" Airline config
let g:airline#extensions#tabline#enabled=1
let g:airline_section=''
let g:airline_detect_paste=1
let g:airline_powerline_fonts=1
if !exists('g:airline_symbols')
	let g:airline_symbols = {}
endif

" Unicode symbols
let g:airline_left_sep = '»'
let g:airline_right_sep = '«'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'

" Airline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''

" Pymode settings
let g:pymode_lint_checkers = ['pep8']

" Editor behavior
syntax on
filetype plugin indent on
set number
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set smartindent

" Set title and allow hidden buffers
set title
set hidden

" Automatically remove trailing whitespace on :w
autocmd BufWritePre * :%s/\s\+$//e

" Autosave files when focus is lost
:au FocusLost * :wa

" Path
set path=$PWD/**

" Wild menu (Autocompletion)"
set wildignore=.svn,CVS,.git,*.o,*.a,*.class,*.mo,*.la,*.so,*.obj,*.swp,*.jpg,*.jpeg,*.png,*.xpm,*.gif
set wildmode=list:longest,full

" Search options
set hlsearch
set magic
set ignorecase
set smartcase

" Folding
set foldenable
set foldmethod=marker
set foldlevel=0
set foldcolumn=0

" Language options
let python_highligh_all=1

" Colors
colorscheme gruvbox
set background=dark

" UI options
set termencoding=utf-8
set encoding=utf-8
set fileencoding=utf-8
set showmatch
set cursorline
set scrolljump=10
set ttyfast
set nostartofline
set noswapfile

set clipboard=unnamedplus

nmap <silent> <leader>/ :nohlsearch<CR>
map <F2> :!cargo run<CR>
