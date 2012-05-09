set nocompatible
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
runtime vim-bundles.vim

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

" Use command line window 
set cmdwinheight=3
set cedit=<c-f>
nnoremap : :<c-f>i
nnoremap / /<c-f>i
nnoremap ? ?<c-f>i
" Use command line
nnoremap q: :
nnoremap q/ /
nnoremap q? ?
augroup command_win
    au!
    " Mapping for quitting command line window
    au CmdwinEnter * nnoremap <buffer> <c-c> <esc>o<cr>
    au CmdwinEnter * inoremap <buffer> <c-c> <esc>o<cr>
    au CmdwinEnter * onoremap <buffer> <c-c> <esc>o<cr>
augroup END

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

set completeopt=menuone,longest,preview
let g:SuperTabDefaultCompletionType="context"

hi link EasyMotionTarget ErrorMsg
