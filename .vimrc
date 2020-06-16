" ▄▄▄▄· ▄• ▄▌▪  ▄▄▌ ▄▄▄▄▄▄ ▄▄▄·  ▄· ▄▌ ▄▄·  ▄▄▄· ▄▄▄  .▄▄ ·        ▐ ▄     ▄▄·       • ▌ ▄ ·.
" ▐█ ▀█▪█▪██▌██ ██•  •██  ▐█ ▀█▪▐█▪██▌▐█ ▌▪▐█ ▀█ ▀▄ █·▐█ ▀. ▪     •█▌▐█   ▐█ ▌▪▪     ·██ ▐███▪
" ▐█▀▀█▄█▌▐█▌▐█·██▪   ▐█.▪▐█▀▀█▄▐█▌▐█▪██ ▄▄▄█▀▀█ ▐▀▀▄ ▄▀▀▀█▄ ▄█▀▄ ▐█▐▐▌   ██ ▄▄ ▄█▀▄ ▐█ ▌▐▌▐█·
" ██▄▪▐█▐█▄█▌▐█▌▐█▌▐▌ ▐█▌·██▄▪▐█ ▐█▀·.▐███▌▐█ ▪▐▌▐█•█▌▐█▄▪▐█▐█▌.▐▌██▐█▌   ▐███▌▐█▌.▐▌██ ██▌▐█▌
" ·▀▀▀▀  ▀▀▀ ▀▀▀.▀▀▀  ▀▀▀ ·▀▀▀▀   ▀ • ·▀▀▀  ▀  ▀ .▀  ▀ ▀▀▀▀  ▀█▄▀▪▀▀ █▪ ▀ ·▀▀▀  ▀█▄▀▪▀▀  █▪▀▀▀
" A vimrc carefully created for optimal productivity and speed
" that utilizes vim's best features.
" https://github.com/carsin/dotfiles

" General {{{
" syntax highlighting based on file names
filetype plugin on
filetype indent on
syntax on
syntax enable

set hidden " keep more info in memory to speed things up
set history=500 " How many lines of history vim has to remember

set autoread " Set to auto read when a file is changed from the outside

" Turn backup off, since most stuff is in SVN, git etc anyway...
set nobackup
set nowb
set noswapfile

set encoding=utf8 " Set utf8 as standard encoding and en_US as the standard language
set ffs=unix,dos,mac " Use Unix as the standard file type

set mouse=a
set updatetime=300 " Fast updatetime for snappier experience
" }}}
" Plugins {{{
call plug#begin('~/.vim/plugged') " Specify a directory for plugins

Plug 'sainnhe/gruvbox-material' " Colorscheme
Plug 'tpope/vim-surround' " Easy matching pairs
Plug 'itchyny/lightline.vim' " Nice status bar
Plug 'scrooloose/nerdtree' " File tree navigator
Plug 'mattn/emmet-vim' " Emmet integration
Plug 'ctrlpvim/ctrlp.vim' " Ctrl+p to open files
Plug 'preservim/nerdcommenter' " Easy commenting
Plug 'jiangmiao/auto-pairs' " Auto pairs
Plug 'rust-lang/rust.vim' " Nice rust files
Plug 'neoclide/coc.nvim', {'branch': 'release'} " Autocomplete

call plug#end() " Initialize plugin system
" }}}
" Plugin Settings {{{
let g:lightline = {'colorscheme' : 'gruvbox_material'}
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif " Close vim if nerdtree is the only window left
map <C-n> :NERDTreeToggle<CR>
" }}}
" Editing {{{
set expandtab " Use spaces instead of tabs
set smarttab " Be smart when using tabs ;)
set ai " Auto indent
set si " Smart indent
set wrap " Wrap lines
" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4
" Line break on 500 characters
set lbr
set tw=500

set incsearch " search as characters are entered
set hlsearch " highlight matches
set ignorecase " Ignore case when searching
set smartcase " When searching try to be smart about cases
set clipboard=unnamed " yank across instances

" move vertically by visual line
nnoremap j gj
nnoremap k gk
" highlight last insert text
nnoremap gV `[v`]
" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l
" Enable persistent undo so that undo history persists across vim sessions
set undofile
set undodir=~/.vim/undo
autocmd BufWritePre * :%s/\s\+$//e " remove trailing whitespace on save
" }}}
" UI {{{
" Set up gruvbox material colorscheme
if has('termguicolors')
    set termguicolors
endif
set background=dark
colorscheme gruvbox-material

" Fix cursor on windows terminal
if &term =~ '^xterm'
    let &t_EI .= "\<Esc>[0 q"
    let &t_SI .= "\<Esc>[6 q"
endif

set t_Co=256 " 256 colors
set so=10 " Set 10 lines to the cursor - when moving vertically using j/k
set number " line numbering
set showcmd " show last entered command
set wildmenu " visual auto complete for command menu
set lazyredraw " redraw only when needed
set showmatch " highlight matching [{()}]
set noeb vb t_vb= " no visual bell or beeping (thank god)
set ruler " Always show current position
set magic " For regular expressions turn magic on
set laststatus=2 " Set status bar
set noshowmode " Remove redundant status bar elements
set foldenable " Fold code
set foldmethod=marker " Fold code with {{{}}}
set linespace=0 " No extra space between lines
" }}}
" Binds & Mappings {{{
let mapleader=" " "leader = space

" save file
nmap <leader>w :w!<cr>

" reload vim configuration
map <leader>r :source ~/.vimrc<CR>

 " clear search
nnoremap <leader><space> :noh<CR><CR>

" jk is escape
inoremap jk <ESC>

" Remap VIM 0 to first non-blank character
map 0 ^
" }}}