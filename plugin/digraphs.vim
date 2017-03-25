" digraphs.vim: defines a bunch of digraphs I'll never use.

" Digraph Aliases:
" ∞: symbol for infinity, more obvious than 00
digraph oo 8734

" π: symbol for pi, although *p makes sense as the Greek letter pi, PI
" is more obvious to me in the context of math
digraph PI 960
" Replacement digraph for the Pilgrow/paragraph symbol (¶), which used
" to be represented by the digraph PI
digraph PG 182

" θ: symbol for theta, like π, it is a little more obvious than *h
" 0 is used rather than O because O- is Ō
digraph 0- 952

" ∏: symbol for product, more obvious than *P, especially because of the
" distinction between P* (Π) and *P (∏)
digraph ** 8719

" ∑: symbol for summation, way more obvious than +Z
" Note: this overwrites ARABIC TATWEEL (ـ), but because that digraph is
" non-obvious and because using digraphs for writing Arabic text sounds
" like a bad idea and not something I expect to do, I really don't care
digraph ++ 8721

" Åå: Aa with ring above, consistency with _0 for ring above vs AA
digraph A0 197
digraph a0 229

" —: em dash, although M- is a good digraph, I slightly prefer -- as
" that is how I represent em dashes in ascii.
digraph -- 8212
" Replacement digraph for soft hyphen (­), which used to be represented
" by the digraph --
digraph -? 173
" Replacement digraph for wave dash (〜), which used to be represented
" by the digraph -?
digraph ~- 12316

" ‾: overline, more obvious than '-
digraph ^_ 8254



" Superscripts And Subscripts:
" ⁰¹²³⁴⁵⁶⁷⁸⁹⁺⁻⁼⁽⁾ⁿ: superscript aliases for the _S digraphs
digraph ^0 8304
digraph ^1 185
digraph ^2 178
digraph ^3 179
digraph ^4 8308
digraph ^5 8309
digraph ^6 8310
digraph ^7 8311
digraph ^8 8312
digraph ^9 8313
digraph ^+ 8314
digraph ^- 8315
digraph ^= 8316
digraph ^( 8317
digraph ^) 8318
digraph ^n 8319

" ₀₁₂₃₄₅₆₇₈₉₊₋₌₍₎: subscript aliases for the _s digraphs
" A leading _ makes a bit more sense, but leading _s are reserved in vim
" See ``:h :dig`` and RFC1347
digraph #0 8320
digraph #1 8321
digraph #2 8322
digraph #3 8323
digraph #4 8324
digraph #5 8325
digraph #6 8326
digraph #7 8327
digraph #8 8328
digraph #9 8329
digraph #+ 8330
digraph #- 8331
digraph #= 8332
digraph #( 8333
digraph #) 8334
" ₙ: subscript n, added for consistency with superscripts.  Really I
" should just do all the letters, but that's a project for when I
" actually care.
digraph #n 8345



" Symbols For Mathematical Sets:
" ℂ: symbol for the set of all complex numbers
digraph CC 8450
" Replacement digraph for the CCH cancel character, which used to be
" represented by the digraph CC
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
