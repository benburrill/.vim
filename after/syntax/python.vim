" Syntax highlighting for Python 3.6 f-strings {{{1
" Note: nested replacement fields do not work, and are likely either
" impossible to implement with regexes or require a level of Vim
" wizardry that I do not yet comprehend.

" These string regions are heavily inspired by what python.vim does.  We
" don't need to worry about fu"" strings or the like because they are
" invalid syntax (and wouldn't make much sense in Python 3 anyway)
syntax region pythonFormatString matchgroup=pythonQuotes
    \ start=/[fF]\z(['"]\)/ end=/\z1/ skip=/\\\\\|\\\z1/ keepend
    \ contains=pythonEscape,pythonFormatStringReplacementField,@Spell
syntax region  pythonFormatString matchgroup=pythonTripleQuotes
    \ start=/[fF]\z('''\|"""\)/ end=/\z1/ keepend
    \ contains=pythonEscape,pythonSpaceError,pythonFormatStringReplacementField,@Spell
syntax region pythonFormatRawString matchgroup=pythonQuotes
    \ start=/\%([rR][fF]\|[fF][rR]\)\z(['"]\)/ end=/\z1/ skip=/\\\\\|\\\z1/ keepend
    \ contains=pythonFormatStringReplacementField,@Spell
syntax region  pythonFormatRawString matchgroup=pythonTripleQuotes
    \ start=/\%([rR][fF]\|[fF][rR]\)\z('''\|"""\)/ end=/\z1/ keepend
    \ contains=pythonSpaceError,pythonFormatStringReplacementField,@Spell

" We use quotes as delimiters here because the '{'s seem to break vim
" syntax highlighting when you use / as the delimiter.  
" The main idea of the start regex is to match an odd number of opening
" '{'s in a row.  The first and last '{'s in the pattern verify that we
" are not looking at the middle of a long chain of '{'s.
syntax region pythonFormatStringReplacementField matchgroup=pythonFormatStringBrackets 
    \ start="{\@<!\%({{\)*\zs{{\@!" end="}" keepend
    \ contains=pythonFormatStringExpression,pythonFormatStringConverter,pythonFormatStringFormatSpec contained
syntax match pythonFormatStringExpression /\_.\+/ 
    \ contains=ALLBUT,@pythonContextSensitiveSyntax,@Spell contained

" The converter should always be 's', 'r', or 'a' in f-string literals,
" but we match any character so that this can more easily be used for
" any format strings.  There should never be any character after the
" converter other than ':' or '}'.
syntax match pythonFormatStringConverter /!.\ze[:}]/ nextgroup=pythonFormatStringFormatSpec contained

" Proper syntax highlighting for the format spec is pretty much
" impossible because classes can implement __format__, so we don't worry
" about any more specific syntax highlighting than this.
syntax match pythonFormatStringFormatSpec /:\_.*\ze}/ contained

" python.vim *should* have made a cluster like this, but it didn't.
" Because of this, python.vim won't be able to know about the f-string
" syntax and when not to use it.  Still, we can make such a group for
" our internal use.
syntax cluster pythonContextSensitiveSyntax contains=pythonDoctest,pythonDoctestValue
syntax cluster pythonContextSensitiveSyntax add=pythonFunction,pythonDecoratorName,pythonDecorator
syntax cluster pythonContextSensitiveSyntax add=pythonFormatStringReplacementField,pythonFormatStringExpression,pythonFormatStringConverter,pythonFormatStringFormatSpec

highlight default link pythonFormatString pythonString
highlight default link pythonFormatRawString pythonRawString
highlight default link pythonFormatStringBrackets Statement
highlight default link pythonFormatStringConverter Type
highlight default link pythonFormatStringFormatSpec Operator
" }}}1

" vim: foldmethod=marker
