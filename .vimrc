	if v:progname =~? "evim"
filetype plugin indent on
  finish
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" these are all links to github repos,  just go look them up for more info on
" each
Plugin 'gmarik/Vundle.vim'
"The plugin manager
Plugin 'bling/vim-airline'
" The fancy bars upp and down (These might not look great for you if you don't
" have a powerline font.)
Plugin 'scrooloose/nerdtree.git'
" The nerd tree traversal plugin
Plugin 'scrooloose/syntastic'
" Syntax checker
Plugin 'jiangmiao/auto-pairs'
" automatically pairs bracers
Plugin 'Lokaltog/vim-easymotion'
" lets you move around, mainly for showing off
Plugin 'tpope/vim-fugitive'
" handy git shortcuts.
Plugin 'kien/ctrlp.vim'
" Best plugin ever,  epic code traversal
Plugin 'hynek/vim-python-pep8-indent.git'
" Better indent for python
Plugin 'majutsushi/tagbar'
" Code overview via tags
Bundle 'godlygeek/tabular'
" ... I don't remember, probably dumb
Bundle 'MarcWeber/vim-addon-mw-utils'
" ... Also don't remember
Bundle 'tomtom/tlib_vim'
" ... Becoming a theme
Bundle 'justinmk/vim-syntax-extra'
" ... More syntax is better
Bundle 'vim-scripts/TagHighlight'
" ... better C highlighting
" Bundle 'garbas/vim-snipmate' I don't use these but they are good
" Bundle 'honza/vim-snippets'
" Bundle 'jlanzarotta/bufexplorer'
Bundle 'tomtom/tcomment_vim'
" lets you comment out things with gcc 
Bundle 'sjl/gundo.vim'
" Undo/redo on steroids
call vundle#end()
" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup          " do not keep a backup file, use versions instead
else
  set backup            " keep a backup file (restore to previous version)
  set backupdir=~/.vim/tmp
  set undofile          " keep an undo file (undo changes after closing)
  set undodir=~/.vim/tmpun
endif
set history=500          " keep 50 lines of command line history
set undolevels=200
set ruler               " show the cursor position all the time
set showcmd             " display incomplete commands
set incsearch           " do incremental searching
set tabstop=4
set softtabstop=4
set shiftwidth=4
set noexpandtab
set number
set colorcolumn=120

highlight ColorColumn ctermbg=darkgray
" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq
map <C-n> :NERDTreeToggle<CR>
nmap <F8> :TagbarToggle<CR>
nnoremap <silent> <Leader>/ :nohlsearch<CR>
nnoremap <F5> :GundoToggle<CR>
filetype plugin indent on
" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif
set incsearch
set modeline
" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=100

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent                " always set autoindenting on

endif " has("autocmd")
set background=dark
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
"Syntastic crap
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 2
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_c_check_header = 1
let g:syntastic_c_auto_refresh_includes = 1
let g:syntastic_cpp_check_header = 1
let g:syntastic_cpp_auto_refresh_includes = 1
let g:syntastic_loc_list_height=3
map <C-l> :lopen<CR>
map <C-m> :lclose<CR>


"Airline crap
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_theme='badwolf'
set laststatus=2
set timeoutlen=400
set noshowmode
set ttyfast
set lazyredraw
" Convenient command to see the difference between the current buffer and the
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
                  \ | wincmd p | diffthis
endif

augroup reload_vimrc "{
	autocmd!
	autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END
	"}

set t_Co=256
colorscheme Benokai
