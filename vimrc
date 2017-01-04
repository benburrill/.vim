execute pathogen#infect()
execute pathogen#infect("~/.vim-bundle/{}")
call pathogen#helptags()

set nocompatible
filetype plugin indent on

" The space bar is big and easy to reach, so it makes a good <Leader>
let mapleader="\<Space>"

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

" Prefer undofiles (placed in a separate directory) to backups.
" Backups can be nice, but I think that undofiles should have all the
" advantages of backups without getting in the way all the time.  You
" can put backups in their own directory with backupdir, but they don't
" get unique names, so it isn't particularly useful.
if has("persistent_undo")
    set nobackup
    set undofile
    set undodir=~/.vimundo/
    
    " undodir needs to exist in order for this to work, so make sure it
    " does.
    if exists("*mkdir") && !isdirectory(expand(&undodir))
        call mkdir(&undodir)
    endif
else
    " If we can't make undofiles just throw backups wherever vim feels
    " like.
    set backup
endif

" Store netrw stuff elsewhere
let g:netrw_home=expand("~")

" Mappings:
" Sane Y behavior
map Y y$

" Use backspace for deletion
nmap <BS> X
xmap <BS> x

" Make it easy to focus on the undo tree
nmap <silent> <Leader>u :UndotreeShow<CR>:UndotreeFocus<CR>

" Sometimes I want to base64-decode things, and this makes it easy to do
" so.  It is compatible with both bash and batch assuming the base64 and
" printf programs exist.  The parentheses are used to get around what
" appears to be a vim bug on windows.  :Gblame this for more info.
vmap <silent> <Leader>b64 :w !<Space>(base64 -d && printf "\n")<CR>

let s:movv = ["<Up>", "<Down>", "k", "j"]
let s:movh = ["<Left>", "<Right>", "h", "l"]
let s:mov = s:movv + s:movh

" Swap the behavior for dealing with wrapped lines, the default becomes
" the g-behavior (see :h gk), and the g versions are mapped to the old
" default.  In insert mode, we must be careful not to mess up the
" popupmenu-keys, so we must test to see if we're in the popup menu.
inoremap <expr> <Up> pumvisible()? "\<Up>" : "\<C-o>g\<Up>"
inoremap <expr> <Down> pumvisible()? "\<Down>" : "\<C-o>g\<Down>"
for s:key in s:movv
    execute "noremap" s:key "g".s:key
    execute "noremap" "g".s:key s:key
endfor

" Easier window navigation (space+arrows/hjkl)
for s:key in s:mov
    execute "map" "<Leader>".s:key "<C-w>".s:key
endfor

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
set hlsearch

" Make removing search highlighting a little easier.  We can't simply
" use the <Esc> key because it would conflict with the arrow keys, so we
" must use <Esc><Esc>.  However, with <Esc><Esc>, it becomes easy to do
" something like <Esc><Up> which inserts 'A' on the line above.  To fix
" this, we do an <Esc> at the end.  After that, everything will work,
" but make a beep if you do an <Esc> first, as that is the default
" behavior of normal mode <Esc>, so we no-op <Esc> to get rid of the
" beep.
nmap <silent> <Esc><Esc> :nohl<CR><Esc>
nmap <Esc> <NOP>

" Use the incsearch plugin (even better than plain incsearch)
" See https://github.com/haya14busa/incsearch.vim for more
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

" Don't conceal anything in TeX because that makes it look awful!
let g:tex_conceal = ""
