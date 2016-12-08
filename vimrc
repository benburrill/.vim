" When editing these settings, I can use :so % to reload the file and
" view the changes in action

" Use pathogen for plugins
execute pathogen#infect()
" *I* like to get crazy
Helptags

" Essentials
set nocompatible
filetype plugin indent on

" Don't use timeouts to determine the ends of mappings
set notimeout ttimeout

" Turn on line numbers
set number

" Turn on spell-check in US English
set spell
set spelllang=en_us
set spellfile=~/en.utf-8.add

" UTF-8 pls
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

" Sane Y behavior
map Y y$

" Use backspace for deletion
nmap <BS> X
xmap <BS> x

" \u = focus on undo tree
nmap <silent> <leader>u :UndotreeShow<CR>:UndotreeFocus<CR> 

" ; echo is good at the end but not batch compatible, && gets escaped to
" ^&^& so it doesn't work either.  TODO: figure something out.
vmap <silent> <leader>b64 :w !base64 -d<CR>

" Put backups in a temporary directory and store undo files in
" ~/.vimundo, otherwise they would clutter up project directories.
set backup
let &backupdir=fnamemodify(tempname(), ":h") . "/"
if has("persistent_undo")
    set undofile
    set undodir=~/.vimundo/
endif

" Swap the behavior for dealing with wrapped lines, the default becomes
" the g-behavior (see :h gk), and the g versions are mapped to the old
" default.  TODO: clean this up a bit with some functions!
inoremap <Up> <C-o>g<Up>
inoremap <Down> <C-o>g<Down>
noremap <Up> g<Up>
noremap g<Up> <Up>
noremap <Down> g<Down>
noremap g<Down> <Down>
noremap k gk
noremap gk k
noremap j gj
noremap gj j

" Easier window navigation (meta+arrows/hjkl)
" TODO: meta keys don't really work in the terminal
map <M-Up> <C-w><Up>
map <M-Down> <C-w><Down>
map <M-Left> <C-w><Left>
map <M-Right> <C-w><Right>|" neo-nazi
map <M-h> <C-w>h
map <M-j> <C-w>j
map <M-k> <C-w>k
map <M-l> <C-w>l

" Interobang digraph, because why not?
digraph !? 8253
digraph ?! 8253

" Completion:
" Make supertab choose completions based on context and remove previews
" (useful for stuff like pythoncomplete)
let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabClosePreviewOnPopupClose = 1

set omnifunc=syntaxcomplete#Complete

" PYTHON 3 IS THE FUTURE!
" TODO: should we move this into ftplugin?
if has("python3")
    autocmd FileType python set omnifunc=python3complete#Complete
endif

" Sane wildmenu completion, I've played around with a few of these, but
" I think this one's the best.  Also make sure we have wildmenu.
set wildmenu
set wildmode=longest:full,full

" Searching:
" Use incremental searching
set incsearch

" Make removing search highlighting a little easier
nnoremap <silent> <Esc><Esc> :nohl<CR>

" Use the incsearch plugin (even better than plain incsearch)
" See https://github.com/haya14busa/incsearch.vim for more
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)
