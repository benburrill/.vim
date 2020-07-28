execute pathogen#infect()
execute pathogen#infect('~/.vim-bundle/{}')
call pathogen#helptags()

set nocompatible
set encoding=utf-8
filetype plugin indent on
colorscheme potato

" Prefer unix line endings on all platforms (including windows)
" Maybe not a great idea, but at least it's more consistent.
set fileformats=unix,dos

" The space bar is big and easy to reach, so it makes a good <Leader>
let mapleader="\<Space>"

" Don't use timeouts to determine the ends of mappings
set notimeout ttimeout

" Show line numbers
set number

" Show certain invisible characters
set list
set listchars=trail:·,tab:──

" Spell-check
set spell
set spelllang=en_us

" Use some pep8-style formatting options
set expandtab
set tabstop=4
set shiftwidth=4
set textwidth=72

" Now that we've set textwidth, vim auto-hard-wraps, so we remove that
" option from formatoptions.
set formatoptions-=t

" Show a colorcolumn right after textwidth
" Ideally I'd prefer the colorcolumn to extend to the end of the screen,
" but there are a lot of problems with getting that to work well...
" I suppose a single column isn't all that bad.
set colorcolumn=+1

" Show incomplete commands at the bottom right of the screen
set showcmd

" Backspace sanity
set backspace=2

" Let blocks be blocks
set virtualedit=block

" Use the mouse, even in the terminal
set mouse=a

set undofile
if exists('*mkdir')
    " If possible, put many vim related files into out-of-the-way
    " directories.

    silent! call mkdir(expand('~/.local/share/vim'), 'p')
    let g:netrw_home=expand("~/.local/share/vim")
    set spellfile=~/.local/share/vim/en.utf-8.add
    silent! call mkdir(expand('~/.local/share/vim/backup'), 'p')
    set backupdir^=~/.local/share/vim/backup//
    silent! call mkdir(expand('~/.local/share/vim/swap'), 'p')
    set directory^=~/.local/share/vim/swap//
    silent! call mkdir(expand('~/.local/share/vim/undo'), 'p')
    set undodir=~/.local/share/vim/undo
endif

" Restore cursor position when loading file
augroup restore_cursor
    autocmd!
    " Copied from :help restore-cursor
    autocmd BufReadPost *
      \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
      \ |   exe "normal! g`\""
      \ | endif
augroup END

" Mappings:
" Sane Y behavior
map Y y$

" Line text-objects
omap <silent> il :normal! ^vg_<CR>
omap <silent> al :normal! 0v$<CR>
xmap <silent> <expr> il line('v') == line('.')? "^og_" : (line('v') > line('.')? "^" : "g_")
xmap <silent> <expr> al line('v') == line('.')? "0o$" : (line('v') > line('.')? "0" : "$")

" File text-objects
omap af :normal! ggVG<CR>
omap if :normal! gg0vG$<CR>
xmap af :<C-u>normal! ggVG<CR>
xmap if :<C-u>normal! gg0vG$<CR>

" Make it easy to focus on the undo tree
nmap <silent> <Leader>u :UndotreeShow<CR>:UndotreeFocus<CR>

" Yank output of a command
" TODO: is there a good way to allow different registers to be chosen to
" yank to?  :command-register seems like it might be useful, but since
" <reg> is empty when not given, it's a bit of a pain to handle (since
" :redir needs an actual register name).
command! -complete=command -nargs=+ YankCmd execute
    \ 'redir @" | silent <args> | redir END'

" Sometimes I want to base64-decode things, and this makes it easy to do
" so.  It is compatible with both bash and batch assuming the base64 and
" printf programs exist.  The parentheses are used to get around what
" appears to be a vim bug on windows.  :Gblame this for more info.
xmap <silent> <Leader>b64 :w !<Space>(base64 -d && printf "\n")<CR>
nmap <Leader>b64 viW<Leader>b64

let s:movv = ['<Up>', '<Down>', 'k', 'j']
let s:movh = ['<Left>', '<Right>', 'h', 'l']
let s:mov = s:movv + s:movh

" Swap the behavior for dealing with wrapped lines, the default becomes
" the g-behavior (see :h gk), and the g versions are mapped to the old
" default.  In insert mode, we must be careful not to mess up the
" popupmenu-keys, so we must test to see if we're in the popup menu.
inoremap <expr> <Up> pumvisible()? "\<Up>" : "\<C-o>g\<Up>"
inoremap <expr> <Down> pumvisible()? "\<Down>" : "\<C-o>g\<Down>"
for s:key in s:movv
    execute 'noremap' s:key 'g'.s:key
    execute 'noremap' 'g'.s:key s:key
endfor

" Easier window navigation (space+arrows/hjkl)
for s:key in s:mov
    execute 'map' '<Leader>'.s:key '<C-w>'.s:key
endfor

" Completion:
" Better wildmenu completion, I've played around with a few of these,
" but I think this one's the best.  Also make sure we have wildmenu.
set wildmenu
set wildmode=longest:full,full

" Make supertab choose completions based on context and remove previews
" (useful for stuff like pythoncomplete)
let g:SuperTabDefaultCompletionType = 'context'
let g:SuperTabClosePreviewOnPopupClose = 1
let g:SuperTabCrMapping = 1

set completeopt=menu,longest,preview
set omnifunc=syntaxcomplete#Complete

function! <SID>feed_esc()
    " Simulates [t]yping an escape character.  Useful when mapping <Esc>
    " because by [i]nserting the <Esc> before the characters from the
    " mapping, it can be included as part of compound escape sequences
    " such as arrow keys that tend to conflict with <Esc> mappings.

    " TODO: looks like the 'i' flag is somewhat new (7.4.601).  I think
    " it might be a good idea to fall back on my old <Esc><Esc> mappings
    " or something in older versions of vim.  I also don't quite trust
    " feedkeys() in general quite yet, and I think it would be wise to
    " test it on a variety of platforms/terminals.
    call feedkeys("\<Esc>", 'nti')
    return ''
endfunc

" Searching:
set incsearch
set hlsearch

" Ignore case when searching unless pattern contains capital letters
set ignorecase
set smartcase

" Use <Esc> in normal mode to clear search highlighting
nmap <silent> <Esc> :nohl<CR>:call <SID>feed_esc()<CR>
" Since the feed_esc() triggers the default <Esc> mapping, our mapping
" doesn't actually get rid of the default normal-mode mapping of <Esc>,
" which is to ring the bell, but that can be disabled with belloff.
set belloff+=esc

" Use the incsearch plugin (even better than plain incsearch)
" See https://github.com/haya14busa/incsearch.vim for more
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)
