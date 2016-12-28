" Match anything in yamlComments and spellcheck it.
syntax match yamlCommentSpell "." contains=@Spell containedin=yamlComment contained transparent
