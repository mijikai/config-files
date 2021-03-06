if has("win32")
    let g:skip_loading_mswin=1  " Disable the specific configuration for mswin
    if !exists('g:loaded_win_vimrc')
        let g:loaded_win_vimrc = 1
        source $VIM\_vimrc  " Load the default configuration for windows
    endif
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

set nocompatible  " Disable compatibility with vi so that plugins will work
filetype off  " Disable first filetype detection for vundle plugin

runtime vim-bundles.vim  " Load the plugins

exec 'set rtp+=' . bundle_folder . '/vim-pathogen/'
call pathogen#infect()

filetype on
filetype indent on
filetype plugin on
syntax on

set lazyredraw  " Do not simulate command record
set smartindent  " Indent automatically
set shiftwidth=4  " One tab equals four spaces
set expandtab  " Convert tab to spaces
set scrolloff=3  " Ensure that the cursor will not need to go to the edge to scroll
set history=10000  " Have a very long history

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

let g:solarized_termtrans=1  " Make sure that the background transparency is used
set background=dark  " Make use of the dark colorset of the current theme
colorscheme solarized  " Use solarized for editing


"""""""""""""""""""""""
" Gundo configuration "
"""""""""""""""""""""""
" Display or hide the history of the undos
nnoremap <Leader>u :GundoToggle<CR>
" Change mapping for window command leader
nnoremap ;w <c-w>


"""""""""""""""""""""""""""""""""
" MiniBufExplorer configuration "
"""""""""""""""""""""""""""""""""
let g:miniBufExplModSelTarget = 1
let g:miniBufExplForceSyntaxEnable = 1  " Force highlighting
let g:miniBufExplCloseOnSelect = 1  " Close when selected a buffer

set completeopt=menu,longest,preview  " Display a menu for autocompletion
let g:SuperTabDefaultCompletionType="context"  " Make a contextual completion


""""""""""""""""""""""""""""
" EasyMotion configuration "
""""""""""""""""""""""""""""
" Make the characters in to find highlight with the color of ErrorMsg.
hi link EasyMotionTarget ErrorMsg
" Shade characters within the search space
hi link EasyMotionShade Comment
noremap ;f <Nop>
let g:EasyMotion_leader_key = ';f'


"""""""""""""""""""""""""""
" vim-slime configuration "
"""""""""""""""""""""""""""
let g:slime_target = 'tmux'

" IPython has an error when it is pastedirectly so have a toggle if one will
" use ipython for interaction
function! Slime_ipython_toggle()
    if !exists('g:slime_python_ipython') || g:slime_python_ipython == 0
        let g:slime_python_ipython = 1
    else
        unlet g:slime_python_ipython
    endif
endfunction
map <C-c>i :silent! call Slime_ipython_toggle()<CR>

""""""""""""""""""""""""""""""
" javacomplete configuration "
""""""""""""""""""""""""""""""
autocmd Filetype java setlocal omnifunc=javacomplete#Complete
