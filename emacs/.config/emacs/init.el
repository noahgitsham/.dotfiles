; Show startup time
(add-hook 'emacs-startup-hook
	  (lambda()
	    (message "Emacs loaded in %s"
		     (format "%.2f seconds"
			     (string-to-number (emacs-init-time))))))

;; Package Manager
;(load "elpaca" nil t)
(defvar elpaca-installer-version 0.7)
(defvar elpaca-directory (expand-file-name "elpaca/" emacs-data-path))
(defvar elpaca-builds-directory (expand-file-name "builds/" elpaca-directory))
(defvar elpaca-repos-directory (expand-file-name "repos/" elpaca-directory))
(defvar elpaca-order '(elpaca :repo "https://github.com/progfolio/elpaca.git"
                              :ref nil :depth 1
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
                 ((zerop (apply #'call-process `("git" nil ,buffer t "clone"
                                                 ,@(when-let ((depth (plist-get order :depth)))
                                                     (list (format "--depth=%d" depth) "--no-single-branch"))
                                                 ,(plist-get order :repo) ,repo))))
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
    (load "./elpaca-autoloads")))
(add-hook 'after-init-hook #'elpaca-process-queues)
(elpaca `(,@elpaca-order))

;; Install use-package support
(elpaca elpaca-use-package
  ;; Enable :elpaca use-package keyword.
  (elpaca-use-package-mode)
  ;; Assume :elpaca t unless otherwise specified.
  (setq use-package-always-ensure t))

;; Fix weird startup message
;;(setq elpaca-core-date '(20231211))
(elpaca-wait)

;; Vim emulation
(use-package evil
  :ensure t
  :demand t
  :init
  ;; Move normally on wrapped text
  (setq evil-respect-visual-line-mode t)
  :config
  (evil-set-undo-system 'undo-redo)
  (setq scroll-step 1 ; Vim scrolling
  	scroll-margin 8) ; Scrolloff
  (setq evil-echo-state nil)
  ;; C-w in minibuffer
  (add-hook 'minibuffer-mode-hook (lambda () (local-set-key (kbd "C-w") 'backward-kill-word)))
  ;; Fix org src indentation
  (add-to-list 'evil-buffer-regexps '("^\\*Org Src .*\\*$" . nil))
  ;; Hide "Quit" on ex command exit TODO
  ;(advice-add 'abort-recursive-edit :around (lambda (orig-fun &rest args)
  ;					      (let ((inhibit-message t))
  ;						(apply orig-fun args))))
  ;; Allow :x to close read only buffers
  (advice-add 'evil-save-modified-and-close :around (lambda (orig-fun &rest args)
						      (if buffer-read-only
							  (kill-buffer-and-window)
							(apply orig-fun args))))
  ;; Enable evil
  (evil-mode 1))


;;;;;;;;;;;;;;;;
;; UI Changes ;;
;;;;;;;;;;;;;;;;
(if (find-font (font-spec :name "Hack"))
    (set-frame-font "Hack 14" nil t))

(set-face-attribute 'variable-pitch nil :family "Helvetica Neue" :weight 'bold)

;;;;;;;;;;;;;;;;;;;;
;; Colour Schemes ;;
;;;;;;;;;;;;;;;;;;;;
(use-package gruvbox-theme)
(use-package leuven-theme)
(use-package doom-themes
  :init
  (setq doom-gruvbox-dark-variant "hard")
  (load-theme 'modus-operandi t)
  :config
  (setq doom-themes-enable-bold t
        doom-themes-enable-italic t)
  (doom-themes-org-config)
  ;; Overrides
  ;(set-face-attribute 'org-todo nil :foreground "Yellow")
  (set-face-italic-p 'line-number nil)
  (set-face-italic-p 'line-number-current-line nil)
  (set-face-attribute 'mode-line nil :background "#32302F")
  (set-face-attribute 'header-line nil :background "#32302F")
  (steal-face-attribute 'line-number :background 'default)
  (steal-face-attribute 'line-number-current-line :background 'default)
  )

;(defun switch-theme ()
;  (interactive)
;  )

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

;; Mode line
(setq line-number-mode nil ; Hide line number
      mode-line-modes nil  ; Hide modes
      )
(setq-default mode-line-format nil)
      ;;'("%e" mode-line-front-space
      ;;	(:propertize
      ;;	 ("" mode-line-client mode-line-modified)
      ;;	 display
      ;;	 (min-width
      ;;	  (2.0)))
      ;;	evil-mode-line-tag
      ;;	mode-line-buffer-identification
      ;;	mode-line-modes mode-line-misc-info mode-line-end-spaces))

;; Header line
(setq-default header-line-format
	      '("" header-line-indent
		(:propertize
		 ("" mode-line-modified)
		 display
		 (min-width
		  (2.0)))
		" "
		mode-line-buffer-identification
		))

;; Remove cursor blinking
(if (window-system)
    (blink-cursor-mode -1)
  (setq visible-cursor nil))

;; Line numbers
;(global-display-line-numbers-mode 1)
(setq display-line-numbers-type 'visual
      display-line-numbers-grow-only t
      display-line-numbers-offset 1)
(add-hook 'prog-mode-hook 'display-line-numbers-mode)
;(display-line-numbers-mode -1)

;; Minibuffer
(setq read-buffer-completion-ignore-case t)

(defun my-command-error-function (data context caller)
  "Ignore the buffer-read-only, beginning-of-buffer,
end-of-buffer signals; pass the rest to the default handler."
  (when (not (memq (car data) '(buffer-read-only
                                beginning-of-buffer
                                end-of-buffer)))
    (command-error-default-function data context caller)))

(setq command-error-function #'my-command-error-function)

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
  (solaire-global-mode 1)

  )


(defun steal-face-attribute (face attribute source &optional frame)
  (set-face-attribute face frame attribute (face-attribute source attribute)))

(steal-face-attribute 'mode-line :background 'minibuffer-prompt)

;;;;;;;;;;;;;;
;; Org Mode ;;
;;;;;;;;;;;;;;
(use-package org
  :ensure (:repo "https://git.tecosaur.net/tec/org-mode.git")
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
	 )
  :init
  (setq org-preview-latex-image-directory "~/.local/share/emacs/ltximg/")

  :config
  (setq org-M-RET-may-split-line nil)
  (evil-define-key 'normal org-mode-map (kbd "<tab>") #'org-cycle)
  (evil-define-key 'normal org-mode-map (kbd "M-<tab>") #'org-cycle)
  ;; Enter insert mode after inserting heading in normal mode
  (evil-define-key 'normal org-mode-map (kbd "C-<return>")
    #'(lambda () (interactive) (org-insert-heading-respect-content) (evil-append 1)))
  (evil-define-key 'normal org-mode-map (kbd "C-S-<return>")
    #'(lambda () (interactive) (org-insert-todo-heading-respect-content 1) (evil-append 1)))
  (evil-define-key 'normal org-mode-map (kbd "M-<return>")
    #'(lambda () (interactive) (org-meta-return) (evil-append 1)))
  (evil-define-key 'normal org-mode-map (kbd "M-S-<return>")
    #'(lambda () (interactive) (org-insert-todo-heading 1) (evil-append 1)))

  ;; Editing Style
  (setq org-startup-indented t
	org-hide-leading-stars t
	org-auto-align-tags nil
	org-tags-column 0)
  ;;(load "rougier-org" nil t)

  (add-to-list 'font-lock-extra-managed-props 'display)
  (font-lock-add-keywords 'org-mode
			  `(("[^:]\\( \\)\\(:.*:\\)$"
			     (1 `(face nil
				       display (space :align-to (- right ,(length (match-string 2)) 3)))
				prepend))) t)

  ; Do not insert new line between headers and list elements
  (setq org-blank-before-new-entry '((heading . nil) (plain-list-item . nil)))
  (add-hook 'org-mode-hook 'visual-line-mode)

  ;; LaTeX Fragments
  (with-eval-after-load 'org
    (add-to-list 'org-latex-packages-alist '("" "amssymb" t) '("" "amsmath" t)))
  (add-hook 'org-mode-hook 'org-latex-preview-auto-mode)
  (setq org-latex-preview-numbered t
	org-latex-preview-live t
	org-latex-preview-live-debounce 0.25
	org-startup-with-latex-preview t)

  ;; Tables
  ;(load "org-table-live-update" nil t)
  ;(add-hook 'org-mode-hook 'org-table-auto-align-mode)

  ;; Blocks
  (setq org-src-tab-acts-natively t
	org-src-preserve-indentation nil)

  ;; TODO
  (setq org-todo-keywords
	'((sequence "TODO(t)" "|" "DONE(d)")
	  (sequence "|" "CANCELED(c)")
	  (sequence "|" "WORKING(w)")))
  (setq org-log-done 'time)

  ;; Priorities
  (setq org-priority-highest 1
	org-priority-default 2
	org-priority-lowest  3)

  ;; Agenda
  (setq org-agenda-files '("~/uni" "~/documents" "~/todo.org")
	org-agenda-span 22
	org-agenda-start-on-weekday nil
	org-agenda-start-day "-7d"
	org-agenda-window-setup 'current-window
	org-agenda-confirm-kill t)
  (add-hook 'org-trigger-hook 'save-buffer)
  ;; Agenda views
  (setq org-agenda-custom-commands
	'(("n" "Agenda and all TODOs" ((agenda "")(alltodo "")))
	  ("c" "Calendar view" cfw:open-org-calendar)
	  ("u" "Uni agenda view" ((agenda "")(tags "uni")))
	  ;; GTD
	  ("g" . "Getting Things Done")
	  ;; Eisenhower Matrix
	  ("ga" "Do" (agenda ""))       ("gc" "Schedule" (agenda ""))
	  ("gb" "Delegate" (agenda ""))	("gd" "Eliminate" (agenda ""))
	  ))

  ;; Agenda style
  (setq org-agenda-tags-column 0
	org-agenda-block-separator ?─
	org-agenda-prefix-format '((agenda . "%t ")
				   (todo . " %i %-12:c")
				   (tags . " %i %-12:c")
				   (search . "asdfad %i %-12:c"))
	org-agenda-remove-tags t
	;;org-agenda-category-icon-alist '(())
	)

  ;; Calendar
  (setq calendar-week-start-day 1)

  ;; Capture
  (setq org-capture-templates '())

  ;; Babel
  (org-babel-do-load-languages
   'org-babel-load-languages '((C . t)
			       (python . t)
			       (shell . t)
			       (emacs-lisp . t)))
  (setq org-confirm-babel-evaluate nil)
  ;(setq org-babel-default-header-args '(:results "output"))

  ;; Exporting
  (setq org-export-with-section-numbers nil)

  ;; Custom face changes
  (with-eval-after-load 'org
    (set-face-attribute 'org-document-title nil :inherit 'variable-pitch :height 3.0 :box '(:line-width 20 :color "#1d2021"))
    (set-face-attribute 'org-document-info nil :inherit 'variable-pitch)
    )
  (setq org-todo-keyword-faces
	'(("TODO" . error)
	  ("DONE" . success)
	  ("CANCELED" . shadow)))
  )

;; Super agenda
;;(use-package org-super-agenda
;;  :init
;;  :config
;;  )

;; Org mode style
(use-package org-modern
  :after org
  :hook org-mode-hook
  :init
  ;;(add-hook 'org-mode-hook #'org-modern-mode)
  ;;(add-hook 'org-agenda-finalize-hook #'org-modern-agenda)
  :config
  (setq org-modern-star       'fold
	org-modern-fold-stars '((">" . "*"))
	org-modern-progress   nil
	org-modern-table      nil
	org-modern-keyword    nil
	org-modern-checkbox   nil
	org-modern-block-name nil)
  (setq org-modern-label-border 0
	org-modern-block-fringe 20)
  (set-face-attribute 'org-modern-label nil :width 'regular :height 1.0)
  (set-face-attribute 'org-block-begin-line nil :width 'regular :height 1.0)
  (set-face-attribute 'org-modern-tag nil :foreground "white")
  (setq org-modern-todo-faces ;; TODO make work
  	(quote (("TODO"     :background (face-foreground 'error)   :weight bold)
  		("DONE"     :background "green" :weight bold)
		("CANCELED" :background "blue"  :weight bold))))

  (setq org-modern-priority-faces
	(quote ((?A :background "red")
		(?B :background "orange")
		(?C :background "yellow")))))

(use-package org-modern-indent
  :ensure (:host github :repo "jdtsmith/org-modern-indent")
  :after org-modern
  :hook org-mode-hook
  :init
  ;;(add-hook 'org-modern-mode-hook #'org-modern-indent-mode)
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
  (add-hook 'org-mode-hook 'org-appear-mode)
  )

;; Org Download
(use-package org-download
  :hook org-mode-hook
  :config
  (require 'org-download))

;;(use-package org-timeblock
;;  :after org
;;  :config
;;  (display-line-numbers-mode -1)
;;  ;(setq org-timeblock-svg)
;;  )

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

(use-package smartparens
  :config
  (require 'smartparens-config)
  (smartparens-global-mode 1))

;; Snippets
;(use-package yasnippet
;  :config
;  ;; Org snippets
;  (add-hook 'org-mode-hook 'yas-minor-mode)
;  ()
;  )

;; Olivetti
(use-package olivetti
  :init
  (setq olivetti-body-width 60)
  (add-hook 'org-mode-hook 'olivetti-mode)
  :config
  (setq olivetti-style  'fancy)
  ;;(steal-face-attribute 'olivetti-fringe :background 'menu)
  (set-face-attribute 'olivetti-fringe nil :background "#282828")
  ;;(set-face-attribute 'fringe nil :background "red")
  )


;;;;;;;;;;;
;; Utils ;;
;;;;;;;;;;;
(use-package free-keys)

;; Load profiling
(use-package esup
  :ensure t
  :config (setq esup-depth 0)
  )

;; Runtime profiling
(global-set-key (kbd "M-p") 'profiler-start)
(global-set-key (kbd "M-P") 'profiler-stop)

;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Custom Set Variables ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq custom-file (locate-user-emacs-file "custom.el"))
(load custom-file 'noerror 'nomessage)
