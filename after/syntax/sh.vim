" Fix annoying sh.vim bug.  Thanks to @birkelund for tracking this down.
" See: https://github.com/vim/vim/issues/6416
syn region shDoubleQuote matchgroup=shQuote start=+"+ skip=+\\"+ end=+"+
    \ contained contains=@shDblQuoteList,shStringSpecial,@Spell
    \ nextgroup=shSpecialStart
