set nocompatible

call plug#begin('~/.vim/plugged')
    " Colorschemes
    Plug 'chriskempson/base16-vim'
    Plug 'whatyouhide/vim-gotham'

    " Airline
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'

    " Syntax
    Plug 'dag/vim-fish'
    Plug 'othree/html5.vim'
    Plug 'hail2u/vim-css3-syntax'
    Plug 'pangloss/vim-javascript'
    Plug 'MaxMEllon/vim-jsx-pretty'
    Plug 'jparise/vim-graphql'
    Plug 'godlygeek/tabular'
    Plug 'plasticboy/vim-markdown'

    " Lang utils
    Plug 'flowtype/vim-flow'
    Plug 'mattn/emmet-vim'
    Plug 'tpope/vim-surround'
    Plug 'autozimu/LanguageClient-neovim', {
        \ 'branch': 'next',
        \ 'do': 'bash install.sh',
        \ }
    Plug 'Shougo/deoplete.nvim', {'do': ':UpdateRemotePlugins' }
    Plug 'reasonml-editor/vim-reason-plus'

    " Intellisense / linting
    Plug 'w0rp/ale'
    Plug 'SirVer/ultisnips'
    Plug 'honza/vim-snippets'

    "Plug 'valloric/YouCompleteMe'

    " Misc
    Plug 'junegunn/fzf', {
                \ 'dir': '~/.fzf',
                \ 'do': './install --all'
                \ }

    " Javascript
    Plug 'Galooshi/vim-import-js'
call plug#end()

set encoding=utf-8
set expandtab
set autoindent
set fileformat=unix

set tabstop=4
set shiftwidth=4
set softtabstop=4
" set textwidth=79

set noswapfile
set number
set autochdir
set hidden

let mapleader = ","

autocmd FileType javascript,json setlocal ts=2 sw=2 sts=2
autocmd BufNewFile,BufRead .prettierrc,.gqlconfig,.babelrc,.eslintrc,.tern-project set filetype=json
autocmd BufNewFile,BufRead *.tsx set filetype=typescript.tsx

nnoremap <C-h> :tabprevious<CR>
nnoremap <C-l> :tabnext<CR>

" Colors
let base16colorspace=256
colorscheme base16-github

" Javascript / JSX
let g:jsx_ext_required = 0

" Flow
let g:flow#enable = 0
let g:flow#errjmp = 0

" ALE
let g:ale_completion_enabled = 0
let g:ale_fix_on_save = 1
let g:ale_linters = {
            \ 'javascript': ['flow', 'eslint'],
            \ }
let g:ale_fixers = {
            \ 'javascript': ['prettier'],
            \ }
let g:ale_sign_error = 'X'
let g:ale_sign_warning = '?'
let g:ale_statusline_format = ['X %d', '? %d', '']
let g:ale_echo_msg_format = '[%linter%] %s'
let g:airline#extensions#ale#enabled = 1

highlight clear ALEErrorSign
highlight clear ALEWarningSign

nnoremap <leader>an :ALENextWrap<CR>
nnoremap <leader>ap :ALEPreviousWrap<CR>

" Deoplete
let g:deoplete#enable_at_startup = 1

" FZF
let g:fzf_action = {
    \ 'ctrl-t': 'tab split',
    \ 'ctrl-x': 'split',
    \ 'ctrl-v': 'vsplit',
    \}

" LSP
let g:LanguageClient_autoStart = 1
let g:LanguageClient_diagnosticsEnable = 0
let g:LanguageClient_serverCommands = {
   \ 'reason': ['ocaml-language-server', '--stdio'],
   \ 'ocaml': ['ocaml-language-server', '--stdio'],
   \ 'javascript': ['javascript-typescript-stdio'],
   \ 'javascript.jsx': ['javascript-typescript-stdio'],
   \ }

" UltiSnips
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsSnippetDirectories=['UltiSnips', 'snips']

"nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
"nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
"nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>
