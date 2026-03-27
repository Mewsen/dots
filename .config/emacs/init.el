;;; init.el -*- lexical-binding: t -*-

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)

(use-package undo-tree
  :ensure t
  :custom
  (undo-tree-auto-save-history t)
  :config
  (setq minor-mode-alist (assq-delete-all 'undo-tree-mode minor-mode-alist))
  (global-undo-tree-mode 1))

(use-package no-littering
  :ensure t
  :config
  (setq no-littering-etc-directory
		(expand-file-name "emacs/etc/"
                          (or (getenv "XDG_CONFIG_HOME")
                              "~/.config/")))

  (setq no-littering-var-directory
		(expand-file-name "emacs/"
                          (or (getenv "XDG_DATA_HOME")
                              "~/.local/share/")))

  ;; Put lockfiles in a dedicated directory
  (let ((lock-dir (no-littering-expand-var-file-name "lock-files/")))
	(make-directory lock-dir t)
	(setq lock-file-name-transforms
          `((".*" ,lock-dir t))))

  ;; recentf exclusions
  (with-eval-after-load 'recentf
	(add-to-list 'recentf-exclude
				 (recentf-expand-file-name no-littering-var-directory))
	(add-to-list 'recentf-exclude
				 (recentf-expand-file-name no-littering-etc-directory)))

  ;; Keep customize output separate
  (setq custom-file
		(expand-file-name "custom.el" user-emacs-directory))

  ;; Native compilation cache
  (when (and (fboundp 'startup-redirect-eln-cache)
			 (fboundp 'native-comp-available-p)
			 (native-comp-available-p))
	(startup-redirect-eln-cache
	 (convert-standard-filename
      (expand-file-name "var/eln-cache/"
						user-emacs-directory))))

  (no-littering-theme-backups)
  )

(use-package tab-bar
  :ensure nil
  :demand t
  :config
  (tab-bar-mode 1)
  )

(use-package evil
  :ensure t
  :demand t
  :init
  (setq evil-want-keybinding nil
        evil-undo-system 'undo-tree
        evil-want-C-u-scroll t)

  (defun my/evil-vsplit-follow ()
    "Split the current window to the right and select the new window."
    (interactive)
    (select-window (split-window-right)))

  (defun my/evil-split-follow ()
    "Split the current window below and select the new window."
    (interactive)
    (select-window (split-window-below)))

  :bind
  (:map evil-window-map
        ("v" . my/evil-vsplit-follow)
        ("s" . my/evil-split-follow))

  (:map evil-motion-state-map
        ("TAB" . nil))

  (:map evil-visual-state-map
		("C-x C-e" . eval-region))

  :config
  (evil-mode 1)

  (evil-define-key 'insert minibuffer-mode-map
    (kbd "TAB") 'undefined
    (kbd "<tab>") 'undefined
    (kbd "<backtab>") 'undefined
    (kbd "C-p") 'minibuffer-previous-completion
    (kbd "C-y") 'minibuffer-complete-and-exit
    (kbd "C-SPC") 'minibuffer-complete
    (kbd "C-n") 'minibuffer-next-completion))

(defun my/evil-jump-back-or-xref ()
  "Go back via xref if possible, otherwise use Evil jump backward."
  (interactive)
  (condition-case nil
      (xref-go-back)
    (error
     (condition-case nil
         (evil-jump-backward 1)
       (error nil)))))

(defun my/evil-jump-forward-or-xref ()
  "Go forward via xref if possible, otherwise use Evil jump forward.
Do nothing if neither is possible."
  (interactive)
  (condition-case nil
      (xref-go-forward)
    (error
     (condition-case nil
         (evil-jump-forward 1)
       (error nil)))))


(use-package emacs
  :ensure nil
  :demand t
  :bind
  (:map evil-normal-state-map
		("C-i" . my/evil-jump-forward-or-xref)
		("TAB" . my/evil-jump-forward-or-xref)
		("C-o" . my/evil-jump-back-or-xref)

		:map evil-motion-state-map
		("C-i" . my/evil-jump-forward-or-xref)
		("TAB" . my/evil-jump-forward-or-xref)
		("C-o" . my/evil-jump-back-or-xref)

		:map evil-visual-state-map
		("C-i" . my/evil-jump-forward-or-xref)
		("TAB" . my/evil-jump-forward-or-xref)
		("C-o" . my/evil-jump-back-or-xref))

  (:map evil-normal-state-map
		("C-t" . tab-new))

  (:map evil-normal-state-map
		("C--" . text-scale-decrease)
		("C-=" . text-scale-increase))
  ("C-x ESC ESC" . undefined)
  :custom
  (debug-on-error t)
  (tab-width 4)
  (standard-indent 4)
  (c-ts-mode-indent-offset 4)
  (python-indent-offset 4)
  (js-indent-level 4)
  (typescript-ts-mode-indent-offset 4)
  (rust-ts-mode-indent-offset 4)

  (truncate-lines t)

  (tab-always-indent t)
  (create-lockfiles nil)
  (go-ts-mode-indent-offset 4)
  (html-ts-mode-indent-offset 4)
  (blink-cursor-mode nil)



  (whitespace-style '(face tabs spaces tab-mark trailing space-mark))

  ;; Auto-revert tuning (the mode itself is enabled in :config)
  (auto-revert-avoid-pulling t)
  (auto-revert-interval 5)
  (auto-revert-check-vc-info t)

  ;; What a sentence is considered.
  (sentence-end-double-space nil)

  ;; Trashing instead of removing
  (delete-by-moving-to-trash t)
  (remote-file-name-inhibit-delete-by-moving-to-trash t)

  ;; Never cache remote file-names
  (remote-file-name-inhibit-cache nil)

  ;; Dired: suggest the other visible Dired buffer as copy/rename target.
  (dired-dwim-target t)

  (cursor-in-non-selected-windows nil)

  (highlight-nonselected-windows nil)

  (ffap-machine-p-known 'reject)

  (window-combination-resize t)

  (help-window-select t)

  (xref-show-xrefs-function #'xref-show-definitions-completing-read)
  (xref-show-definitions-function #'xref-show-definitions-completing-read)

  (read-extended-command-predicate #'command-completion-default-include-p)

  (mode-line-percent-position nil)
  (display-line-numbers-type 'relative)

  (bidi-display-reordering 'left-to-right)

  (bidi-paragraph-direction 'left-to-right)
  (bidi-inhibit-bpq t)
  (redisplay-skip-fontification-on-input t)

  (inhibit-compacting-font-caches t)

  :config
  (defgroup project-local nil
	"Local, non-VC-backed project.el root directories."
	:group 'project)

  (defcustom project-local-identifier ".project"

	"You can specify a single filename or a list of names."
	:type '(choice (string :tag "Single file")
                   (repeat (string :tag "Filename")))
	:group 'project-local)

  (cl-defmethod project-root ((project (head local)))
	"Return root directory of current PROJECT."
	(cdr project))

  (defun project-local-try-local (dir)
	"Determine if DIR is a non-VC project.
DIR must include a file with the name determined by the
variable `project-local-identifier' to be considered a project."
	(if-let* ((root (if (listp project-local-identifier)
						(seq-some (lambda (n)
									(locate-dominating-file dir n))
								  project-local-identifier)
					  (locate-dominating-file dir project-local-identifier))))
		(cons 'local root)))

  (customize-set-variable 'project-find-functions
                          (list #'project-try-vc
								#'project-local-try-local))

  (set-face-attribute 'default nil
					  :family "OperatorMono Nerd Font"
					  :height 140)

  (set-face-attribute 'fixed-pitch nil
					  :family "OperatorMono Nerd Font"
					  :height 1.0)

  (set-face-attribute 'variable-pitch nil
					  :family "Aporetic Sans"
					  :height 1.0)

  (set-face-attribute 'font-lock-comment-face nil
					  :slant 'italic)

  (set-face-attribute 'font-lock-doc-face nil
					  :slant 'italic)

  (set-fontset-font t 'symbol "OperatorMono Nerd Font")

  (dolist (hook '(org-mode-hook vterm-mode-hook pdf-view-mode-hook eshell-mode-hook))
	(add-hook hook
              (lambda ()
				(display-line-numbers-mode 0))))

  (set-fringe-mode '(0 . 10))
  (global-auto-revert-mode 1)
  (global-visual-line-mode 1)
  (global-whitespace-mode 1)
  (file-name-shadow-mode 1))



(use-package ediff
  :demand t
  :ensure nil
  :custom
  (ediff-keep-variants nil)
  (ediff-split-window-function 'split-window-horizontally)
  (ediff-window-setup-function 'ediff-setup-windows-plain)
  )

(use-package flyspell
  :ensure nil
  :demand t
  :bind
  (:map evil-normal-state-map
		("C-x @" . flyspell-buffer))
  )

(use-package ansi-color
  :ensure nil
  :demand t
  :hook (compilation-filter . ansi-color-compilation-filter))

(use-package editorconfig
  :ensure nil
  :demand t
  :config
  (editorconfig-mode 1))

(use-package sudo-edit
  :ensure t
  :demand t
  )

(use-package orderless
  :ensure t
  :demand t
  :custom
  (completion-styles '(orderless basic))
  (completion-category-defaults nil)
  (completion-category-overrides '((file (styles partial-completion)))))

(use-package corfu
  :ensure t
  :demand t
  :bind
  (:map corfu-map
		("RET" . nil)
		("<return>" . nil)
		("C-SPC" . completion-at-point)
		("TAB" . nil)
		("C-y" . corfu-complete))

  ;;(:map corfu-map
  ;;		(:map evil-insert-state-map
  ;;			  ("C-y" . completion-at-point)))
  :custom
  (corfu-cycle t)
  (corfu-preview-current 'nil)
  (corfu-preselect 'prompt)

  :config
  (global-corfu-mode 1)
  (require 'corfu-history)
  (require 'corfu-popupinfo)

  (corfu-history-mode)
  (corfu-popupinfo-mode)
  (setq corfu-popupinfo-delay '(0.0 . 0.0))
  )

(use-package cape
  :ensure t
  :demand t
  :after corfu
  :bind ("C-c p" . cape-prefix-map)
  :config
  (advice-add 'pcomplete-completions-at-point :around #'cape-wrap-silent)
  :init
  ;; extra completion sources
  (add-to-list 'completion-at-point-functions #'cape-dabbrev)
  (add-to-list 'completion-at-point-functions #'cape-file)
  (add-to-list 'completion-at-point-functions #'cape-elisp-block)
  (add-to-list 'completion-at-point-functions #'cape-history)
  )

(use-package apheleia
  :ensure t
  :demand t
  :config
  (apheleia-global-mode +1)
  (setq minor-mode-alist (assq-delete-all 'apheleia-mode minor-mode-alist))
  )

(use-package elisp-refs
  :ensure t
  :demand t
  :after (s f))

(use-package helpful
  :ensure t
  :demand t
  :after (s f elisp-refs)
  :bind
  (([remap describe-function] . helpful-callable)
   ([remap describe-command]  . helpful-command)
   ([remap describe-variable] . helpful-variable)
   ([remap describe-key]      . helpful-key)
   ([remap describe-symbol]   . helpful-symbol)))

(use-package vterm
  :ensure t
  :demand t
  :config
  (defun my/vterm-disable-kill-query ()
    (setq-local kill-buffer-query-functions nil))

  (add-hook 'vterm-mode-hook #'my/vterm-disable-kill-query)

  (defun my/vterm-new-other-window ()
    "Open a new vterm buffer in another window."
    (interactive)
    (let ((vterm-buffer-name (generate-new-buffer-name "*vterm*")))
	  (vterm-other-window)))

  :bind (("C-x T" . my/vterm-new-other-window)))

(use-package annalist
  :ensure t
  :demand t
  :after evil)

(use-package evil-surround
  :ensure t
  :demand t
  :after evil
  :config
  (global-evil-surround-mode 1)
  )

(use-package evil-collection
  :ensure t
  :demand t
  :after (evil)
  :custom
  (evil-collection-calendar-want-org-bindings t)
  (evil-collection-setup-minibuffer t)
  :config
  (evil-collection-init)
  (setq minor-mode-alist (assq-delete-all 'evil-collection-unimpaired-mode minor-mode-alist))
  )

(use-package evil-org
  :ensure t
  :demand t
  :after (evil org)
  :hook (org-mode . evil-org-mode)
  :config
  (require 'evil-org-agenda)
  (evil-org-agenda-set-keys)
  (setq minor-mode-alist (assq-delete-all 'evil-org-mode minor-mode-alist))
  )

(use-package which-key
  :ensure nil
  :demand t
  :config
  (which-key-mode 1)
  (setq which-key-idle-delay 0.1)
  (setq minor-mode-alist (assq-delete-all 'which-key-mode minor-mode-alist))
  )

(use-package pdf-tools
  :ensure t
  :magic ("%PDF" . pdf-view-mode)
  :mode ("\\.pdf\\'" . pdf-view-mode)
  :config
  (pdf-loader-install)

  (setq-default pdf-view-display-size 'fit-height)
  (setq pdf-view-resize-factor 1.1)
  ;; Work around pdf-tools prefetch crash:
  ;; wrong-type-argument number-or-marker-p nil
  (setq pdf-cache-prefetch-delay nil)

  (add-hook 'pdf-view-mode-hook
            (lambda ()
			  (display-line-numbers-mode -1)
			  (auto-revert-mode -1)
			  (blink-cursor-mode -1)
			  (hl-line-mode -1)
        	  (pdf-view-midnight-minor-mode 1)
			  ))

  (with-eval-after-load 'pdf-view
  	(defun my/pdf-ignore-no-such-page-error (orig &rest args)
	  (condition-case err
		  (apply orig args)
  		(error
  		 (unless (string-match-p "No such page" (error-message-string err))
		   (signal (car err) (cdr err))))))

  	(advice-add 'pdf-view-scroll-up-or-next-page
  				:around #'my/pdf-ignore-no-such-page-error)

  	(advice-add 'pdf-view-scroll-down-or-previous-page
  				:around #'my/pdf-ignore-no-such-page-error))

  ;; Function to sync midnight colors with your theme
  (defun my/pdf-set-midnight-colors ()
    (setq pdf-view-midnight-colors
		  (cons (face-foreground 'default)
        		(face-background 'default))))
  
  (defun my/pdf-update-midnight-after-theme (&rest _)
    (when (derived-mode-p 'pdf-view-mode)
	  (my/pdf-set-midnight-colors)
	  (pdf-view-midnight-minor-mode 1)))

  (advice-add 'load-theme :after #'my/pdf-update-midnight-after-theme)
  )

(use-package magit
  :ensure t
  :demand t
  :bind (("C-x g" . magit-status))
  :config
  (copy-face 'magit-diff-added-highlight 'magit-diff-added)
  (copy-face 'magit-diff-removed-highlight 'magit-diff-removed)
  (copy-face 'magit-diff-context-highlight 'magit-diff-context)

  (copy-face 'magit-diff-base-highlight 'magit-diff-base)
  (copy-face 'magit-diff-our-highlight  'magit-diff-our)
  (copy-face 'magit-diff-their-highlight 'magit-diff-their)

  (with-eval-after-load 'project
	(add-to-list 'project-switch-commands
				 '(magit-project-status "Magit status" ?m)
				 t)))

(use-package eglot
  :ensure nil
  :hook ((go-ts-mode . eglot-ensure)
         (rust-ts-mode . eglot-ensure)
         (c-ts-mode . eglot-ensure)
         (c++-ts-mode . eglot-ensure)
         (csharp-ts-mode . eglot-ensure)
         (java-ts-mode . eglot-ensure)
         (LaTeX-mode . eglot-ensure)
         (js-ts-mode . eglot-ensure)
         (typescript-ts-mode . eglot-ensure)
         (tsx-ts-mode . eglot-ensure))
  :demand t
  :custom

  (read-process-output-max (* 4 1024 1024))
  (eglot-extend-to-xref t)
  (eglot-workspace-configuration
   '((gopls . ((buildFlags . ["-tags=mage"])
			   (standaloneTags . ["ignore" "mage"])))))
  :config
  (setq eglot-ignored-server-capabilities '(:inlayHintProvider))
  )

(add-to-list
 'display-buffer-alist
 '("\\*eldoc\\|\\*eldoc-doc\\|\\*EGLOT.*eldoc"
   (display-buffer-in-side-window)
   (side . bottom)
   (slot . 1)
   (window-height . 0.25)
   (dedicated . t)
   (preserve-size . (nil . t))
   (inhibit-same-window . t)))

(setq major-mode-remap-alist
	  '((python-mode     . python-ts-mode)
        (css-mode        . css-ts-mode)
        (js-mode         . js-ts-mode)
        (typescript-mode . typescript-ts-mode)
        (json-mode       . json-ts-mode)
        (c-mode          . c-ts-mode)
        (c++-mode        . c++-ts-mode)
        (c-or-c++-mode   . c-or-c++-ts-mode)
        (bash-mode       . bash-ts-mode)
        (sh-mode         . bash-ts-mode)
        (js-json-mode    . json-ts-mode)
        (yaml-mode       . yaml-ts-mode)
        (ruby-mode       . ruby-ts-mode)
        (java-mode       . java-ts-mode)
        (css-mode        . css-ts-mode)))

(defvar my/treesit-auto-mode-rules
  '((c
     ("\\.c\\'" . c-ts-mode)
     ("\\.h\\'" . c-ts-mode))

    (cpp
     ("\\.cc\\'"  . c++-ts-mode)
     ("\\.cpp\\'" . c++-ts-mode)
     ("\\.cxx\\'" . c++-ts-mode)
     ("\\.c\\+\\+\\'" . c++-ts-mode)
     ("\\.hh\\'"  . c++-ts-mode)
     ("\\.hpp\\'" . c++-ts-mode)
     ("\\.hxx\\'" . c++-ts-mode)
     ("\\.h\\+\\+\\'" . c++-ts-mode)
     ("\\.ipp\\'" . c++-ts-mode)
     ("\\.ixx\\'" . c++-ts-mode)
     ("\\.tpp\\'" . c++-ts-mode))

    (go
     ("\\.go\\'"      . go-ts-mode)
     ("/go\\.mod\\'"  . go-mod-ts-mode)
     ("/go\\.work\\'" . go-mod-ts-mode))

    (typescript
     ("\\.mts\\'" . typescript-ts-mode)
     ("\\.mjs\\'" . typescript-ts-mode)
     ("\\.cjs\\'" . typescript-ts-mode)
     ("\\.cts\\'" . typescript-ts-mode)
     ("\\.ts\\'"  . typescript-ts-mode))

    (tsx
     ("\\.tsx\\'" . tsx-ts-mode))

    (javascript
     ("\\.js\\'"  . js-ts-mode)
     ("\\.jsx\\'" . js-ts-mode))

    (rust
     ("\\.rs\\'" . rust-ts-mode))

    (python
     ("\\.py\\'" . python-ts-mode))

    (yaml
     ("\\.ya?ml\\'" . yaml-ts-mode))

    (json
     ("\\.json\\'"  . json-ts-mode)
     ("\\.jsonc\\'" . json-ts-mode))

    (toml
     ("\\.toml\\'" . toml-ts-mode))

    (css
     ("\\.css\\'" . css-ts-mode))

    (html
     ("\\.html?\\'" . html-ts-mode))

    (bash
     ("\\.sh\\'"   . bash-ts-mode)
     ("\\.bash\\'" . bash-ts-mode))

    (cmake
     ("CMakeLists\\.txt\\'" . cmake-ts-mode)
     ("CMakeCache\\.txt\\'" . cmake-ts-mode)
     ("\\.cmake\\'"         . cmake-ts-mode))

    (dockerfile
     ("Dockerfile\\'"    . dockerfile-ts-mode)
     ("Containerfile\\'" . dockerfile-ts-mode)
     ("\\.dockerfile\\'" . dockerfile-ts-mode)))
  "Filename rules for Tree-sitter major modes.")

(defun my/register-treesit-auto-modes ()
  "Register filename associations for available Tree-sitter modes."
  (interactive)
  (dolist (entry my/treesit-auto-mode-rules)
    (pcase-let ((`(,grammar . ,rules) entry))
	  (dolist (rule rules)
        (when (fboundp (cdr rule))
		  (add-to-list 'auto-mode-alist rule))))))

(my/register-treesit-auto-modes)

(setq treesit-language-source-alist
	  '((bash       . ("https://github.com/tree-sitter/tree-sitter-bash"))
        (c          . ("https://github.com/tree-sitter/tree-sitter-c"))
        (cpp        . ("https://github.com/tree-sitter/tree-sitter-cpp"))
        (css        . ("https://github.com/tree-sitter/tree-sitter-css"))
        (elisp      . ("https://github.com/Wilfred/tree-sitter-elisp"))
        (java       .  ("https://github.com/tree-sitter/tree-sitter-java"))
        (go         . ("https://github.com/tree-sitter/tree-sitter-go"))
        (rust         . ("https://github.com/tree-sitter/tree-sitter-rust"))
        (gomod      . ("https://github.com/camdencheek/tree-sitter-go-mod"))
        (html       . ("https://github.com/tree-sitter/tree-sitter-html"))
        (javascript . ("https://github.com/tree-sitter/tree-sitter-javascript" "master" "src"))
        (json       . ("https://github.com/tree-sitter/tree-sitter-json"))
        (make       . ("https://github.com/alemuller/tree-sitter-make"))
        (markdown   . ("https://github.com/tree-sitter-grammars/tree-sitter-markdown" "split_parser" "tree-sitter-markdown/src"))
        (python     . ("https://github.com/tree-sitter/tree-sitter-python"))
        (toml       . ("https://github.com/tree-sitter/tree-sitter-toml"))
        (tsx        . ("https://github.com/tree-sitter/tree-sitter-typescript" "master" "tsx/src"))
        (typescript . ("https://github.com/tree-sitter/tree-sitter-typescript" "master" "typescript/src"))
		(dockerfile . ("https://github.com/camdencheek/tree-sitter-dockerfile" "main"))
        (yaml       . ("https://github.com/ikatyang/tree-sitter-yaml"))))

(dolist (lang (mapcar #'car treesit-language-source-alist))
  (unless (treesit-language-available-p lang)
    (treesit-install-language-grammar lang)))

(use-package org
  :ensure t
  :hook (org-mode . (lambda () (electric-indent-local-mode -1)))
  :demand t
  :bind
  (( "C-c l" . org-store-link)
   ( "C-c a" . org-agenda)
   ( "C-c c" . org-capture)
   )
  :custom
  (evil-auto-indent nil)
  (org-default-notes-file "~/personal/documents/org/notes.org")
  (org-src-fontify-natively t)
  (org-src-tab-acts-natively t)
  (calendar-week-start-day 1)

  (org-directory "~/personal/documents/org/")
  (org-agenda-files (list (concat org-directory "uni.org")
   						  (concat org-directory "cal.org")
   						  (concat org-directory "dev.org")))
  :config
  (org-indent-mode)

  (with-eval-after-load 'org
	(define-key org-mode-map (kbd "C-<return>")
				(lambda ()
				  (interactive)
				  (if (org-in-item-p)
					  (org-insert-item)
					(org-insert-heading-respect-content)))))

  (add-hook 'org-mode-hook
			(lambda () (font-lock-ensure (point-min) (point-max))))

  (org-babel-do-load-languages
   'org-babel-load-languages
   '((emacs-lisp . t)
     (python . t)
     (shell . t))))

(use-package ef-themes
  :ensure t
  :init
  (ef-themes-take-over-modus-themes-mode 1)
  :bind
  (("<f5>" . modus-themes-rotate)
   ("C-<f5>" . modus-themes-select)
   ("M-<f5>" . modus-themes-load-random))
  :config
  (setq modus-themes-mixed-fonts t)
  (setq modus-themes-italic-constructs t)
  (modus-themes-load-random-light))

;; move this inside a use-package
(dotimes (i 9)
  (let ((n (1+ i)))
    (global-set-key
     (kbd (format "M-%d" n))
     `(lambda ()
        (interactive)
        (tab-bar-select-tab ,n)))))

