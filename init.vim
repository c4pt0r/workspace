set nocompatible              " be iMproved, required
filetype off                  " required set rtp+=~/.vim/bundle/Vundle.vim call vundle#begin() 
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'iamcco/markdown-preview.vim'
Plugin 'gmarik/Vundle.vim'
Plugin 'fatih/vim-go'
Plugin 'ervandew/supertab'
Plugin 'scrooloose/nerdtree'
Plugin 'majutsushi/tagbar'
Plugin 'flazz/vim-colorschemes'
Plugin 'kien/ctrlp.vim'
Plugin 'Raimondi/delimitMate'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'dracula/vim'
Plugin 'godlygeek/tabular'
Plugin 'rust-lang/rust.vim'
Plugin 'racer-rust/vim-racer'
Plugin 'mrtazz/simplenote.vim'
Plugin 'mileszs/ack.vim'
Plugin 'csliu/a.vim'
Plugin 'arcticicestudio/nord-vim'
Plugin 'octol/vim-cpp-enhanced-highlight'
Plugin 'jsfaint/gen_tags.vim'
Plugin 'mdempsky/gocode', {'rtp': 'nvim/'}

call vundle#end()            " required
filetype plugin indent on    " required

set cmdheight=1

let g:SuperTabDefaultCompletionType = "<c-x><c-o>"
set completeopt=longest,menuone

" go-vim
let g:go_fmt_command = "goimports"
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
nmap <F1> :GoDoc<CR>

" search
set incsearch
set ignorecase
set smartcase

" editor settings
set history=1000
set nocompatible
set nofoldenable                                                  " disable folding"
set confirm                                                       " prompt when existing from an unsaved file
set backspace=indent,eol,start                                    " More powerful backspacing
set t_Co=256                                                      " Explicitly tell vim that the terminal has 256 colors "
set mouse=a                                                       " use mouse in all modes
set report=0                                                      " always report number of lines changed                "
set scrolloff=5                                                   " 5 lines above/below cursor when scrolling
set number                                                        " show line numbers
set showmatch                                                     " show matching bracket (briefly jump)
set showcmd                                                       " show typed command in status bar
set title                                                         " show file in titlebar
set laststatus=2                                                  " use 2 lines for the status bar
set matchtime=2                                                   " show matching bracket for 0.2 seconds
set matchpairs+=<:>                                               " specially for html
" set relativenumber

" Default Indentation
set autoindent
set smartindent     " indent when
set tabstop=4       " tab width
set softtabstop=4   " backspace
set shiftwidth=4    " indent width
set expandtab       " expand tab to space

let mapleader=","
syntax on

au FileType go nmap <Leader>gd <Plug>(go-doc)
au FileType go nmap <Leader>gv <Plug>(go-doc-vertical)

au FileType go nmap <leader>r <Plug>(go-run)
au FileType go nmap <leader>b <Plug>(go-build)
au FileType go nmap <leader>t <Plug>(go-test)

au FileType go nmap <C-]> <Plug>(go-def)
au FileType go nmap <Leader>ds <Plug>(go-def-split)
au FileType go nmap <Leader>dv <Plug>(go-def-vertical)
au FileType go nmap <Leader>dt <Plug>(go-def-tab)

" tagbar
let g:tagbar_type_go = {  
    \ 'ctagstype' : 'go',
    \ 'kinds'     : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
\ }

autocmd vimenter * NERDTree
autocmd VimEnter * wincmd p
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

"------------------
"" Useful Functions
"------------------
"" easier navigation between split windows
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

nmap <F8> :TagbarToggle<CR>

syntax enable
set termguicolors
set background=dark
colorscheme deepsea
" colorscheme borland
set showtabline=1

if has("gui_running")
    set go=aAce  " remove toolbar
    " set guifont=Hack:h16
    set guifont=Hasklig:h12
    set lines=999 columns=999
    "set cursorcolumn
    set guioptions=e  " instead of clearing this, set it to only `e`
    "let base16colorspace=256
else
    set nocursorcolumn
    set nocursorline
endif

"" CtrlP
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe  " Windows

let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe  " Windows
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'

vmap <C-x> :!pbcopy<CR>  
vmap <C-c> :w !pbcopy<CR><CR> 

set hidden
let g:racer_cmd = "/Users/dongxu/.cargo/bin/racer"
let g:racer_experimental_completer = 1

au FileType rust nmap gd <Plug>(rust-def)
au FileType rust nmap gs <Plug>(rust-def-split)
au FileType rust nmap gx <Plug>(rust-def-vertical)
au FileType rust nmap <leader>gd <Plug>(rust-doc)
au FileType rust nmap <C-]> <Plug>(rust-def)

"" reveal find in tree
nmap ,n :NERDTreeFind<CR>

" enable ncm2 for all buffers
autocmd Filetype cpp setlocal expandtab tabstop=2 shiftwidth=2

au BufRead,BufNewFile *.vue set filetype=html

"This unsets the "last search pattern" register by hitting return
nnoremap <CR> :noh<CR><CR>
