set nocompatible  " Disable compatibility with vi so that plugins will work
filetype off  " Disable first filetype detection for vundle plugin
set rtp+=~/.vim/bundle/vundle/  " Add vundle to the runtime path
call vundle#rc()  " Initialize vundle for loading of other plugins
runtime vim-bundles.vim  " Load the plugins

if has("win32")
    let g:skip_loading_mswin=1  " Disable the specific configuration for mswin
    source $VIM\_vimrc  " Load the default configuration for windows
    set guifont=Consolas:h9:cANSI  " Set the font for the gui
    set nohlsearch  " Do not highlight search
    set noincsearch " Do not move the cursor to the next match
elseif has("unix")
    runtime ftplugin/man.vim  " Enable the use of man inside vim
    set guifont=Monospace\ 9
endif
if has("gui_running")
    set guicursor+=a:blinkwait0  " Disable blinking
    set guioptions-=m  " Hide menubar
    set guioptions-=T " Hide toolbar
endif

filetype on
filetype indent on
filetype plugin on
syntax on

set smartindent  " Indent automatically
set shiftwidth=4  " One tab equals four spaces
set expandtab  " Convert tab to spaces
set scrolloff=3  " Ensure that the cursor will not need to go to the edge to scroll
set history=100000  " Have a very long history

set showcmd
set hidden  " Enable the change of visible buffer even if the current has been modified

set wildmenu  " Show a list of candidate command in command line
set wildmode=list:longest " List all the longest substring in autocompleting command
set textwidth=79  " Limit the number of characters per line
set mouse-=a  " Disable mouse

set foldmethod=indent  " End a fold when a line has the same indent as initial
set foldlevel=99

set cmdwinheight=3  " Make the command line window occupy three lines
set cedit=<c-f>  " Have this key display the command line window
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

let g:solarized_termtrans=1  " Make sure that the background transparency is used
set background=dark  " Make use of the dark colorset of the current theme
colorscheme solarized  " Use solarized for editing

" Display or hide the history of the undos
nnoremap <Leader>u :GundoToggle<CR>

" MiniBufExplorer config
let g:miniBufExplModSelTarget = 1
let g:miniBufExplForceSyntaxEnable = 1  " Force highlighting
let g:miniBufExplCloseOnSelect = 1  " Close when selected a buffer

set completeopt=menu,longest,preview  " Display a menu for autocompletion
let g:SuperTabDefaultCompletionType="context"  " Make a contextual completion

" Make the characters in to find highlight with the color of ErrorMsg.
hi link EasyMotionTarget ErrorMsg