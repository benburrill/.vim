" This is a pretty hacky way to put spelling where we want it in yaml
" files.  We just match anything that is in yamlComments and spellcheck
" it.  Then, because we've overridden the syntax highlighting for that
" region, we need to link it to yamlComment.  Note that yamlTodo
" highlighting is preserved because it is a keyword, so it has a higher
" priority than match items, see :syn-priority.
syntax match yamlCommentSpell "." contains=@Spell containedin=yamlComment contained
highlight default link yamlCommentSpell yamlComment
