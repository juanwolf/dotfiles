(doom!

:input

:completion
(company +childframe)
(vertico +icons)

:ui
doom
doom-dashboard
doom-quit
(emoji +github +unicode)
hl-todo
indent-guides
modeline
ophints
(popup +defaults)
treemacs
unicode
(vc-gutter +pretty)
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
(syntax +childframe)
;; grammar

:tools
docker
editorconfig
(eval +overlay)
lookup
lsp
(magit +forge)
make
(terraform +lsp)

:os
(:if IS-MAC macos)

:lang
emacs-lisp
(gdscript +lsp)
(go +lsp)
(json)
(javascript +lsp)
markdown
(org +journal +hugo +pretty +gnuplot +pomodoro +roam2)
(python +lsp +pyenv +poetry +pyright)
(rust +lsp)
(sh +lsp)
(web +lsp)
yaml

:email
(mu4e +gmail)

:app
(rss +org)

:config
(default +bindings +smartparens)

;; (literate +literate-config-file (file-name-concat doom-user-dir "slayer.org"))

)
