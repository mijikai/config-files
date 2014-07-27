" Add vundle to the runtime path using the user's vimfiles
let bundle_folder=split(&rtp, ',')[0] . '/bundle'
exec 'set rtp+=' . bundle_folder . '/vundle'

call vundle#begin(bundle_folder)
" Plugin manager
Plugin 'gmarik/vundle'

" Other plugins
Plugin 'Lokaltog/vim-easymotion'
Plugin 'altercation/vim-colors-solarized'
Plugin 'chrisbra/SudoEdit.vim'
Plugin 'ervandew/supertab'
Plugin 'godlygeek/tabular'
Plugin 'jpalardy/vim-slime'
Plugin 'scrooloose/nerdtree'
Plugin 'sjl/gundo.vim'
Plugin 'tomtom/tcomment_vim'
Plugin 'tpope/vim-abolish'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-pathogen'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-unimpaired'
Plugin 'vim-scripts/YankRing.vim'
Plugin 'vim-scripts/bufkill.vim'
Plugin 'vim-scripts/javacomplete'
Plugin 'vim-scripts/pep8'
Plugin 'wlangstroth/vim-racket'
Plugin 'zaiste/tmux.vim'

Plugin 'git://vim-latex.git.sourceforge.net/gitroot/vim-latex/vim-latex'

call vundle#end()
