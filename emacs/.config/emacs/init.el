;; Show startup time
;(add-hook 'emacs-startup-hook
;	  (lambda()
;	    (message "Emacs loaded in %s"
;		     (format "%.2f seconds"
;			     (string-to-number (emacs-init-time))))))

;; Load paths
(add-to-list 'load-path (expand-file-name "elisp" user-emacs-directory))

;; Custom paths
(setq bookmark-default-file "~/.local/share/emacs")
(when (boundp 'native-comp-eln-load-path)
  (startup-redirect-eln-cache "~/.locale/share/emacs/eln-cache"))

(defvar package-source-directory "~/.local/share/emacs")
;; Elpaca
(defvar elpaca-installer-version 0.6)
(defvar elpaca-directory (expand-file-name "elpaca/" package-source-directory))
(defvar elpaca-builds-directory (expand-file-name "builds/" elpaca-directory))
(defvar elpaca-repos-directory (expand-file-name "repos/" elpaca-directory))
(defvar elpaca-order '(elpaca :repo "https://github.com/progfolio/elpaca.git"
                              :ref nil
                              :files (:defaults "elpaca-test.el" (:exclude "extensions"))
                              :build (:not elpaca--activate-package)))
(let* ((repo  (expand-file-name "elpaca/" elpaca-repos-directory))
       (build (expand-file-name "elpaca/" elpaca-builds-directory))
       (order (cdr elpaca-order))
       (default-directory repo))
  (add-to-list 'load-path (if (file-exists-p build) build repo))
  (unless (file-exists-p repo)
    (make-directory repo t)
    (when (< emacs-major-version 28) (require 'subr-x))
    (condition-case-unless-debug err
        (if-let ((buffer (pop-to-buffer-same-window "*elpaca-bootstrap*"))
                 ((zerop (call-process "git" nil buffer t "clone"
                                       (plist-get order :repo) repo)))
                 ((zerop (call-process "git" nil buffer t "checkout"
                                       (or (plist-get order :ref) "--"))))
                 (emacs (concat invocation-directory invocation-name))
                 ((zerop (call-process emacs nil buffer nil "-Q" "-L" "." "--batch"
                                       "--eval" "(byte-recompile-directory \".\" 0 'force)")))
                 ((require 'elpaca))
                 ((elpaca-generate-autoloads "elpaca" repo)))
            (progn (message "%s" (buffer-string)) (kill-buffer buffer))
          (error "%s" (with-current-buffer buffer (buffer-string))))
      ((error) (warn "%s" err) (delete-directory repo 'recursive))))
  (unless (require 'elpaca-autoloads nil t)
    (require 'elpaca)
    (elpaca-generate-autoloads "elpaca" repo)
    (load "./elpaca-autoloads" nil t)))
(add-hook 'after-init-hook #'elpaca-process-queues)
(elpaca `(,@elpaca-order))

;; Install use-package support
(elpaca elpaca-use-package
  ;; Enable :elpaca use-package keyword.
  (elpaca-use-package-mode)
  ;; Assume :elpaca t unless otherwise specified.
  (setq elpaca-use-package-by-default t))
(elpaca-wait)


;; Daemon
;(server-start)

;; Immediate evil mode
(use-package evil
  :ensure t
  :config
  (evil-set-undo-system 'undo-redo)
  (setq scroll-step 1 ; Vim scrolling
	scroll-margin 8) ; Scrolloff
  ;; Move normally on wrapped text
  (setq evil-respect-visual-line-mode t)
  ;; Fix org src indentation
  (add-to-list 'evil-buffer-regexps '("^\\*Org Src .*\\*$" . nil))
  ;; Enable evil
  (evil-mode 1))

;;;;;;;;;;;;;;;;
;; UI Changes ;;
;;;;;;;;;;;;;;;;
(set-frame-font "Hack 12" nil t)
(set-face-attribute 'variable-pitch nil :font "Europa Grotesk SH")

;;;;;;;;;;;;;;;;;;;;
;; Colour Schemes ;;
;;;;;;;;;;;;;;;;;;;;
(use-package gruvbox-theme)
(use-package color-theme-sanityinc-tomorrow)
(use-package doom-themes
  :config
  (setq doom-themes-enable-bold t
        doom-themes-enable-italic t)
  (doom-themes-org-config)
  ;; Overrides
  ;(set-face-attribute 'org-todo nil :foreground "Yellow")
  (load-theme 'doom-tomorrow-day t))

;;;;;;;;;;;;;;
;; Org Mode ;;
;;;;;;;;;;;;;;
(use-package org
  :elpaca (:repo "https://git.tecosaur.net/tec/org-mode.git")
  :defer nil
  :bind ( ;; Global maps
	 ("C-c a" . org-agenda)
	 ("C-c c" . org-capture)
	 ("C-c >" . org-goto-calendar)
	 ("C-c b" . org-switchb)
	 ("C-c s" . org-timeblock)
	 ("C-c d" . cfw:open-org-calendar)
	 :map org-mode-map ;; Local maps
	 ("M-j" . org-forward-heading-same-level)
	 ("M-k" . org-backward-heading-same-level)
	 ("M-h" . org-up-element)
	 ("M-l" . org-down-element)
	 ("M-J" . org-metadown)
	 ("M-K" . org-metaup)
	 ("M-H" . org-shiftmetaleft)
	 ("M-L" . org-shiftmetaright)
	 ("M-C-H" . org-metaleft)
	 ("M-C-L" . org-metaright)
	 ;:map org-agenda-mode-map
	 ;("q" . org-agenda-quit)
	 )
  :init
  (setq org-preview-latex-image-directory "~/.local/share/emacs/ltximg/")

  :config
  (setq org-M-RET-may-split-line nil)
  ;(evil-define-key 'normal org-mode-map (kbd "<tab>") #'org-cycle)
  ;; Enter insert mode after inserting heading in normal mode
  (evil-define-key 'normal org-mode-map (kbd "C-<return>")
    #'(lambda () (interactive) (org-insert-heading-respect-content) (evil-append 1)))
  (evil-define-key 'normal org-mode-map (kbd "C-S-<return>")
    #'(lambda () (interactive) (org-insert-todo-heading-respect-content 1) (evil-append 1)))
  (evil-define-key 'normal org-mode-map (kbd "M-<return>")
    #'(lambda () (interactive) (org-meta-return) (evil-append 1)))
  (evil-define-key 'normal org-mode-map (kbd "M-S-<return>")
    #'(lambda () (interactive) (org-insert-todo-heading 1) (evil-append 1)))

  ;; LaTeX Fragments
  (with-eval-after-load 'org
    (add-to-list 'org-latex-packages-alist '("" "amssymb" t))
    )
  ;; LaTeX Live Preview
  (setq org-latex-preview-live t
	org-latex-preview-live-debounce 1.0
	org-startup-with-latex-preview t)
  (add-hook 'org-mode-hook #'org-latex-preview-auto-mode)

  ;; TODO
  (setq org-todo-keywords
	'((sequence "TODO(t)" "|" "DONE(d)")
	  (sequence "|" "CANCELED(c)")))

  ;; Editing Style
  (setq org-startup-indented t
	org-hide-leading-stars t
	org-auto-align-tags nil
	org-tags-column 0)
  (add-hook 'org-mode-hook 'visual-line-mode)

  ;; Tables
  ;(load "org-table-live-update" nil t)
  ;(add-hook 'org-mode-hook 'org-table-auto-align-mode)

  ;; Blocks
  (setq org-src-tab-acts-natively t
	org-src-preserve-indentation nil)

  ;; Babel
  (org-babel-do-load-languages
   'org-babel-load-languages '((C . t)
			       (python . t)
			       (shell . t)
			       (emacs-lisp . t)))
  ;(setq org-babel-default-header-args '(:results "output"))

  ;; Calendar
  (setq calendar-week-start-day 1)

  ;; Agenda
  (setq ;org-directory "~"
	org-agenda-files '("~/uni" "~/documents" "~/todo.org")
	org-agenda-span 22
	org-agenda-start-on-weekday nil
	org-agenda-start-day "-7d"
	org-agenda-window-setup 'only-window
	org-agenda-confirm-kill t)
  ;; Agenda views
  (setq org-agenda-custom-commands
	'(("n" "Agenda and all TODOs" ((agenda "")(alltodo "")))
	  ("c" "Calendar view" cfw:open-org-calendar)))

  ;; Agenda style
  (setq org-agenda-tags-column 0
	org-agenda-block-separator ?─)

  ;; Exporting
  (setq org-export-with-section-numbers nil)

  ;; Capture
  (setq org-capture-templates '())

  ;; Custom face changes
  (with-eval-after-load 'org
    (set-face-attribute 'org-document-title nil :inherit 'variable-pitch :height 400 :bold nil)
    (set-face-attribute 'org-document-info nil :inherit 'variable-pitch))
  )

;; Startup page
(load "splash-screen" nil t)

;; Behavior
(save-place-mode 1)
(global-auto-revert-mode 1)
(recentf-mode 1)
(setq use-dialog-box nil)
(fset 'yes-or-no-p 'y-or-n-p)
(set-default 'truncate-lines t)

;; Clipboard
(global-set-key (kbd "C-S-V") 'clipboard-yank)
(global-set-key (kbd "C-S-C") 'clipboard-kill-ring-save)
;;(setq x-select-enable-clipboard t)
;;(setq interprogram-paste-function 'x-cut-buffer-or-selection-value)

;; Backups
(make-directory "~/backups/emacs" :parents)
(setq backup-directory-alist '(("." . "~/backups/emacs"))
      backup-by-copying t)

; Mode line
(setq line-number-mode nil ; Hide line number
      mode-line-modes nil  ; Hide modes
      )
(setq mode-line-format
      '("%e" mode-line-front-space
	(:propertize
	 ("" mode-line-client mode-line-modified)
	 display
	 (min-width
	  (2.0)))
	evil-mode-line-tag
	mode-line-frame-identification
	mode-line-buffer-identification
	mode-line-modes mode-line-misc-info mode-line-end-spaces))

;; Remove cursor blinking
(if (window-system)
    (blink-cursor-mode -1)
  (setq visible-cursor nil))

;; Line numbers
(global-display-line-numbers-mode 1)
(display-line-numbers-mode -1)
(setq display-line-numbers-type 'visual
      display-line-numbers-grow-only t
      display-line-numbers-offset 1)

;; Minibuffer
(setq read-buffer-completion-ignore-case t)

(use-package vertico
  :init (vertico-mode 1)
  (add-hook 'minibuffer-setup-hook (lambda () (setq truncate-lines t))))

(use-package marginalia
  :config
  (setq marginalia-align 'right)
  :init
  (marginalia-mode 1)
  )

(use-package solaire-mode
  :init
  (solaire-global-mode 1))


(defun steal-face-attribute (face attribute source &optional frame)
  (set-face-attribute face frame attribute (face-attribute source attribute)))

; Org mode extensions
;(use-package calfw
;  :elpaca (:host github :repo "haji-ali/emacs-calfw")
;  ;:straight (:type git :host github :repo "kiwanami/emacs-calfw" :fork (:host github :repo "haji-ali/emacs-calfw"))
;  :config
;  (steal-face-attribute 'cfw:face-toolbar :background 'cfw:face-toolbar-button-off)
;  ;(steal-face-attribute '
;  )
;
;(use-package calfw-org
;  :after (org calfw))

(use-package org-timeblock
  :after org
  :config
  (display-line-numbers-mode -1)
  ;(setq org-timeblock-svg)
  )

;; Org mode style
(use-package org-modern
  :after org
  :hook org-mode-hook
  :config
  (setq org-modern-star     nil
	org-modern-progress nil
	org-modern-table    nil
	org-modern-keyword  nil
	org-modern-checkbox nil)
  (setq org-modern-label-border 0)
  (set-face-attribute 'org-modern-label nil :width 'regular :height 1.0)
  (set-face-attribute 'org-block-begin-line nil :width 'regular :height 1.0)
  (setq org-modern-todo-faces
	(quote (("CANCELED" :inherit 'ansi-color-cyan :foreground "white" :weight bold)
		("TODO" :inherit 'ansi-color-red :foreground "white" :weight bold)
		("DONE" :inherit 'ansi-color-green :foreground "white" :weight bold))))


  :init
  (add-hook 'org-mode-hook #'org-modern-mode)
  (add-hook 'org-agenda-finalize-hook #'org-modern-agenda))

(use-package org-modern-indent
  :elpaca (:host github :repo "jdtsmith/org-modern-indent")
  :after (org org-modern)
  :hook org-mode-hook
  :init
  (add-hook 'org-modern-mode-hook #'org-modern-indent-mode)
  )


;; Hide verbatim symbols
(use-package org-appear
  :hook org-mode-hook
  :config
  (setq org-appear-trigger 'always
	org-hide-emphasis-markers t
	org-appear-hide-emphasis-markers t
	org-appear-autolinks t
	;org-pretty-entities t
	;org-pretty-entities-include-sub-superscripts nil
	;org-appear-autoentities t
	org-hidden-keywords '(title author date email language)
	org-appear-autokeywords t)
  :init
  (add-hook 'org-mode-hook 'org-appear-mode))

;; Auto LaTeX preview
;(use-package org-fragtog
;  :hook org-modern-mode-hook
;  :init
;  ;(defun latex-preview-toggle () (org-fragtog-mode 1) (org-latex-preview '(16)))
;  (add-hook 'org-mode-hook 'org-fragtog-mode))

;; Org Download
(use-package org-download
  :hook org-mode-hook
  :config
  (require 'org-download))

;; Olivetti
(use-package olivetti
  :init
  (setq olivetti-body-width 100))

;;;;;;;;;;;
;; Utils ;;
;;;;;;;;;;;
(use-package free-keys)

;; Load profiling
(use-package esup
  :ensure t
  :config (setq esup-depth 0)
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Custom Set Variables ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq custom-file (locate-user-emacs-file "custom.el"))
(load custom-file 'noerror 'nomessage)

