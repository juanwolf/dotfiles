;;; init.el -*- lexical-binding: t; -*-

;; This file controls what Doom modules are enabled and what order they load
;; in. Remember to run 'doom sync' after modifying it!

;; NOTE Press 'SPC h d h' (or 'C-h d h' for non-vim users) to access Doom's
;;      documentation. There you'll find a "Module Index" link where you'll find
;;      a comprehensive list of Doom's modules and what flags they support.

;; NOTE Move your cursor over a module's name (or its flags) and press 'K' (or
;;      'C-c c k' for non-vim users) to view its documentation. This works on
;;      flags as well (those symbols that start with a plus).
;;
;;      Alternatively, press 'gd' (or 'C-c c d') on a module to browse its
;;      directory (for easy access to its source code).

(doom! :input
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
       spell
       grammar

       :tools
       (eval +overlay)
       lookup
       lsp
       magit
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
       (org +journal +hugo +pretty +roam)
       (python +lsp)
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
       (default +bindings +smartparens))
