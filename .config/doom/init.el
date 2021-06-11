(doom!

:input

:completion
company
(ivy +icons)

:ui
doom
doom-dashboard
doom-quit
(emoji +unicode)
hl-todo
indent-guides
modeline
ophints
(popup +defaults)
treemacs
unicode
vc-gutter
vi-tilde-fringe
workspaces

:editor
(evil +everywhere)
file-templates
fold
(format +onsave)
snippets

:emacs
dired
electric
undo
vc

:term
vterm

:checkers
syntax
(spell +aspell)
grammar

:tools
editorconfig
(eval +overlay)
lookup
lsp
(magit +forge)
make
terraform

:os
(:if IS-MAC macos)

:lang
emacs-lisp
(go +lsp)
(json +lsp)
(javascript +lsp)
markdown
(org +journal +hugo +pretty +gnuplot +pomodoro)
(python +lsp +pyenv)
(rust +lsp)
(sh +lsp)
(web +lsp)
yaml

:email
(mu4e +gmail)

:app
(rss +org)
twitter

:config
(default +bindings +smartparens)

)
