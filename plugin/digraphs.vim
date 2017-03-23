" digraphs.vim: defines a bunch of digraphs I'll never use.

" Digraph Aliases:
" ∞: symbol for infinity, more obvious than 00
digraph oo 8734

" π: symbol for pi, although *p makes sense as the Greek letter pi, PI
" is more obvious to me in the context of math.
digraph PI 960
" The digraph PI used to stand for the Pilgrow/paragraph symbol (¶), so
" create a replacement digraph for it.
digraph PG 182

" ∏: symbol for product, more obvious than *P, see π
digraph ** 8719

" ∑: symbol for summation, way more obvious than +Z
" Note: this overwrites ARABIC TATWEEL (ـ), but because that digraph is
" non-obvious and because using digraphs for writing Arabic text sounds
" like a bad idea and not something I expect to do, I really don't care.
digraph ++ 8721

" Åå: Aa with ring above, consistency with ?0 for ring above vs AA
digraph A0 197
digraph a0 229



" Symbols For Mathematical Sets:
" ℂ: symbol for the set of all complex numbers
digraph CC 8450
" The digraph CC used to stand for the CCH cancel character, so create a
" replacement digraph for it.
digraph CH 148

" ℕ: symbol for the set of all natural numbers
digraph NN 8469

" ℚ: symbol for the set of all rational numbers
digraph QQ 8474

" ℝ: symbol for the set of all real numbers
digraph RR 8477

" ℤ: symbol for the set of all integers
digraph ZZ 8484



" Fun:
" ‽: Interrobang
digraph !? 8253

" ☹: Frowning face
digraph :( 9785
digraph ): 9785

" ☺: Smiling face, technically an alias for 0u
digraph (: 9786
digraph :) 9786
