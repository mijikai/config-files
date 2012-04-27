set nocompatible
filetype off
call pathogen#infect()
if has("win32")
    let g:skip_loading_mswin=1
    source $VIM\_vimrc
    set guifont=Consolas:h9:cANSI
    set nohlsearch
    set noincsearch
elseif has("unix")
    runtime ftplugin/man.vim
endif
if has("gui_running")
    set guifont=Monospace\ 9
    set guicursor+=a:blinkwait0
endif

filetype on
filetype indent on
filetype plugin on
syntax on

set smartindent
set shiftwidth=4
set expandtab
set scrolloff=3
set history=10000

set showcmd
set hidden

set wildmenu
set wildmode=list:longest
set textwidth=79
set mouse-=a

set foldmethod=indent
set foldlevel=99

let g:solarized_termtrans=1
set background=dark
colorscheme solarized

nnoremap <Leader>u :GundoToggle<CR>

" MiniBufExplorer config
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1 
let g:miniBufExplForceSyntaxEnable = 1

au FileType python set omnifunc=pythoncomplete#Complete
set completeopt=menuone,longest,preview
let g:SuperTabDefaultCompletionType="context"
