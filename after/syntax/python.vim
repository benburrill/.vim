" Syntax highlighting for Python 3.6 f-strings {{{1
" Features:
"  * Nested replacement fields
"  * Converter and format specs are highlighted
"  * Handles escaped '{'s in f-strings
"  * Support for raw and multi-line f-strings
" Todo:
"  * Backslashes in replacement fields should be highlighted with Error
"   * Maybe more error detection too
"  * If possible, highlight the spec when a !s, !r, or !a converter exists

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
    \ start="{\@<!\%({{\)*\zs{{\@!" end="}"
    \ contains=ALLBUT,@pythonContextSensitiveSyntax,@Spell contained

" Add regions for all bracket types.  These eat up legal syntax in
" f-strings, preventing the closing brace of a set or the colon of a
" lambda from being considered part of the replacement field syntax.
" These are actually useful everywhere, so we don't make them contained
" and also add matchgroups for them for convenience.
syntax region pythonInsideParentheses start=/(/ end=/)/
    \ matchgroup=pythonParentheses
    \ contains=ALLBUT,@pythonContextSensitiveSyntax,@Spell
syntax region pythonInsideBrackets start=/{/ end=/}/
    \ matchgroup=pythonBrackets
    \ contains=ALLBUT,@pythonContextSensitiveSyntax,@Spell
syntax region pythonInsideSquareBrackets start=/\[/ end=/]/
    \ matchgroup=pythonSquareBrackets
    \ contains=ALLBUT,@pythonContextSensitiveSyntax,@Spell

syntax match pythonFormatStringBadBackslash /\\/ containedin=pythonFormatStringReplacementField contained

" The converter should always be 's', 'r', or 'a' in f-string literals,
" but we match any character so that this can more easily be used for
" any format strings.  There should never be any character after the
" converter other than ':' or '}'.  We need to do containedin because I
" don't know of another way to add to an ALLBUT contains.
syntax match pythonFormatStringConverter /!.\ze[:}]/ nextgroup=pythonFormatStringFormatSpec containedin=pythonFormatStringReplacementField contained

" Proper syntax highlighting for the format spec is pretty much
" impossible because classes can implement __format__, so we don't worry
" about any more specific syntax highlighting than this.
syntax match pythonFormatStringFormatSpec /:\_.\{-}\ze}/ containedin=pythonFormatStringReplacementField contained

" python.vim *should* have made a cluster like this, but it didn't.
" Because of this, python.vim won't be able to know about the f-string
" syntax and when not to use it.  Still, we can make such a group for
" our internal use.
syntax cluster pythonContextSensitiveSyntax contains=pythonDoctest,pythonDoctestValue
syntax cluster pythonContextSensitiveSyntax add=pythonFunction,pythonDecoratorName,pythonDecorator
syntax cluster pythonContextSensitiveSyntax add=pythonFormatStringReplacementField,pythonFormatStringConverter,pythonFormatStringFormatSpec

highlight default link pythonFormatString pythonString
highlight default link pythonFormatRawString pythonRawString
highlight default link pythonFormatStringBrackets Statement
highlight default link pythonFormatStringConverter Type
highlight default link pythonFormatStringFormatSpec Operator
highlight default link pythonFormatStringBadBackslash Error
" }}}1

" vim: foldmethod=marker
