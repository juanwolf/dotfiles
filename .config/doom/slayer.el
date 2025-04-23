(setq user-full-name "Jean-Loup Adde")

(setq doom-font (font-spec :family "MesloLGL Nerd Font" :size 14 :weight 'normal :slant 'normal)
      doom-variable-pitch-font (font-spec :family "MesloLGL Nerd Font" :size 14 :weight 'normal :slant 'normal))

(setq shr-use-fonts nil)

(setq doom-theme 'doom-bluloco-dark)

(setq display-line-numbers-type t)

(setq-hook! 'python-mode-hook +format-with 'ruff)

(add-hook! 'js2-mode-hook
  (unless (locate-dominating-file default-directory ".prettierrc")
    (format-all-mode -1)))

(setq company-global-modes '(not text-mode org-mode yaml-mode markdown-mode))

(after! treemacs
  (treemacs-follow-mode))

(after! org
  (setq org-adapt-indentation t
        org-startup-indented nil
        org-hide-leading-stars t))

(setq org-directory "~/projects/42"
      org-agenda-files (directory-files-recursively "~/projects/" "\\.org$"))

(after! elfeed
  (require 'elfeed-org)
  (elfeed-org)
  (setq rmh-elfeed-org-files (list "~/projects/42/feeds.org"))
  (setq elfeed-search-filter "@2-weeks-ago +unread"))

(add-hook! 'elfeed-search-mode-hook 'elfeed-update)

(after! writeroom-mode
  (add-hook 'writeroom-mode-hook
            (when (and (eq major-mode 'org-mode) writeroom-mode)
              (setq-local -display-line-numbers display-line-numbers
                          display-line-numbers nil)))
  (add-hook 'writeroom-mode-disable-hook
            (when (eq major-mode 'org-mode)
              (setq-local display-line-numbers -display-line-numbers))))

(setq writeroom-width 0.7)

     (after! editorconfig
       (require 'editorconfig)
       (editorconfig-mode 1))

(defun get-openai-password ()
  "Retrieve the password for the 'openai' host."
  (let ((credentials (auth-source-search :host "openai" :max 1)))
    (if credentials
        (let ((entry (car credentials)))
          (cdr (assoc 'secret entry)))
      (error "No credentials found for 'openai"))))

(after! gptel
  (require 'gptel)
  (use-package! gptel
    :config
    (setq! gptel-api-key (get-openai-password))))

(after! magit
  (setq magit-log-margin
        '(t "%Y-%m-%d" magit-log-margin-width t 18)))
