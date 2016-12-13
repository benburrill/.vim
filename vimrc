execute pathogen#infect()
Helptags

set nocompatible
filetype plugin indent on

" Use <Space> as my <Leader>
let mapleader=" "

" Don't use timeouts to determine the ends of mappings
set notimeout ttimeout

" Line numbers
set number

" Spell-check
set spell
set spelllang=en_us
set spellfile=~/en.utf-8.add

set encoding=utf-8

" Use some pep8-style formatting options
set expandtab
set tabstop=4
set shiftwidth=4
set textwidth=72

" Now that we've set textwidth, vim auto-hard-wraps, so we remove that
" option from formatoptions.
set formatoptions-=t

" Show incomplete commands at the bottom right of the screen
set showcmd

" Backspace sanity
set backspace=2

" Put backups in a temporary directory and store undo files in
" ~/.vimundo, otherwise they would clutter up project directories.
set backup

" Removes everything but the temporary directory on all platforms
set backupdir-=.
set backupdir-=~/
if has("persistent_undo")
    set undofile
    set undodir=~/.vimundo/
    
    " undodir needs to exist in order for this to work, so make sure it
    " does.
    if exists("*mkdir") && !isdirectory(expand(&undodir))
        call mkdir(&undodir)
    endif
endif

" Mappings:
" Sane Y behavior
map Y y$

" Use backspace for deletion
nmap <BS> X
xmap <BS> x

" \u = focus on undo tree
nmap <silent> <Leader>u :UndotreeShow<CR>:UndotreeFocus<CR> 

" ; echo is good at the end but not batch compatible, && gets escaped to
" ^&^& so it doesn't work either.  TODO: figure something out.
vmap <silent> <Leader>b64 :w !base64 -d<CR>

" TODO: clean some of these maps up a bit with some functions

" Swap the behavior for dealing with wrapped lines, the default becomes
" the g-behavior (see :h gk), and the g versions are mapped to the old
" default.  In insert mode, we must be careful not to mess up the
" popupmenu-keys, so we must test to see if we're in the popup menu.
inoremap <expr> <Up> pumvisible()? "\<Up>" : "\<C-o>g\<Up>"
inoremap <expr> <Down> pumvisible()? "\<Down>" : "\<C-o>g\<Down>"
noremap <Up> g<Up>
noremap g<Up> <Up>
noremap <Down> g<Down>
noremap g<Down> <Down>
noremap k gk
noremap gk k
noremap j gj
noremap gj j

" Easier window navigation (space+arrows/hjkl)
map <Leader><Up> <C-w><Up>
map <Leader><Down> <C-w><Down>
map <Leader><Left> <C-w><Left>
map <Leader><Right> <C-w><Right>
map <Leader>h <C-w>h
map <Leader>j <C-w>j
map <Leader>k <C-w>k
map <Leader>l <C-w>l

" Interrobang digraph, because why not‽
digraph !? 8253
digraph ?! 8253

" Completion:
" Make supertab choose completions based on context and remove previews
" (useful for stuff like pythoncomplete)
let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabClosePreviewOnPopupClose = 1

set completeopt=menu,longest,preview
set omnifunc=syntaxcomplete#Complete

" Sane wildmenu completion, I've played around with a few of these, but
" I think this one's the best.  Also make sure we have wildmenu.
set wildmenu
set wildmode=longest:full,full

" Searching:
set incsearch

" Make removing search highlighting a little easier
nnoremap <silent> <Esc><Esc> :nohl<CR>

" Use the incsearch plugin (even better than plain incsearch)
" See https://github.com/haya14busa/incsearch.vim for more
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)
