;; Show startup time
(add-hook 'emacs-startup-hook
	  (lambda()
	    (message "Emacs loaded in %s"
		     (format "%.2f seconds"
			     (float-time (time-subtract after-init-time before-init-time))))))

;; straight setup
(make-directory "~/.local/share/emacs" :parents)
(setq straight-base-dir "~/.local/share/emacs"
      straight-use-package-by-default t
      straight-process-buffer " ")
;; straight.el bootstrap
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name
        "straight/repos/straight.el/bootstrap.el"
        (or (bound-and-true-p straight-base-dir)
            user-emacs-directory)))
      (bootstrap-version 7))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

;; Immediate evil mode
(use-package evil)
(require 'evil)
(evil-mode 1)

;;;;;;;;;;;;;;;;;;;;;;;;;
;; Custom startup page ;;
;;;;;;;;;;;;;;;;;;;;;;;;;
(if (file-exists-p "~/.config/emacs/startupImage")
    (setq fancy-splash-image "~/.config/emacs/startupImage"))

;; (setq fancy-startup-text ((:face variable-pitch "Welcome to buffalo, an emacs configuration for sinners...")))

;; Disable startup nonsense
(setq-default message-log-max nil)

;; Load paths
(add-to-list 'load-path (expand-file-name "elisp" user-emacs-directory))

;; Behavior
(save-place-mode 1)
(global-auto-revert-mode 1)
(recentf-mode 1)
(setq use-dialog-box nil)
(fset 'yes-or-no-p 'y-or-n-p)

;; Clipboard
(global-set-key (kbd "C-S-V") 'clipboard-yank)
(global-set-key (kbd "C-S-C") 'clipboard-kill-ring-save)
;;(setq x-select-enable-clipboard t)
;;(setq interprogram-paste-function 'x-cut-buffer-or-selection-value)

;; Backups
(make-directory "~/backups/emacs" :parents)
(setq backup-directory-alist '(("." . "~/backups/emacs"))
      backup-by-copying t)

;;;;;;;;;;;;;;;;
;; UI Changes ;;
;;;;;;;;;;;;;;;;
(pixel-scroll-mode 0)
(pixel-scroll-precision-mode 0)
(setq pixel-scroll-precision-large-scroll-height 40.0)

;; Themes/Visuals
(set-frame-font "Hack 13" nil t)

;; Remove cursor blinking
(if (window-system)
    (blink-cursor-mode 0)
  (setq visible-cursor nil))

;; Modeline
(setq line-number-mode 'nil)

;; Line numbers
(global-display-line-numbers-mode 1)
(setq display-line-numbers-type 'visual
      display-line-numbers-grow-only t
      display-line-numbers-offset 1)

;; Minibuffer
;;(setq completion-auto-help t)
(setq read-buffer-completion-ignore-case t)

(use-package vertico
  :init
  (vertico-mode))

(setq minibuffer-prompt-properties
      '(read-only t cursor-intangible t face minibuffer-prompt))
(add-hook 'minibuffer-setup-hook #'cursor-intangible-mode)

(use-package marginalia
  :after vertico
  :init
  (marginalia-mode))

(setq marginalia-align 'right)

(add-hook 'icomplete-minibuffer-setup-hook
	  (lambda () (setq truncate-lines t)))

;; Org Babel

;;;;;;;;;;;;;;;;;;;;;
;; Package configs ;;
;;;;;;;;;;;;;;;;;;;;;

;; Evil
(setq evil-undo-system 'undo-redo)

;(setq evil-want-C-u-scroll nil
;      evil-want-C-d-scroll nil)


(setq scroll-step 1 ; Vim scrolling
      scroll-margin 6) ; Scrolloff

;;Move normally on wrapped text
(define-key evil-normal-state-map
	    (kbd "<remap> <evil-next-line>") 'evil-next-visual-line)
(define-key evil-normal-state-map
	    (kbd "<remap> <evil-previous-line>") 'evil-previous-visual-line)
(define-key evil-motion-state-map
	    (kbd "<remap> <evil-next-line>") 'evil-next-visual-line)
(define-key evil-motion-state-map
	    (kbd "<remap> <evil-previous-line>") 'evil-previous-visual-line)


;;;;;;;;;
;; Org ;;
;;;;;;;;;
(use-package org
  :bind ( ;; Global maps
	 ("C-c a" . org-agenda)
	 ("C-c c" . org-capture)
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
	 ("M-C-L" . org-metaright)))


;; Org Templates
(defun promptForWeek () (interactive)
       (read-string "Week number: "))
(defun capture-weekly (path)
  
)

(setq org-capture-templates
      '(("w" "Weekly" entry
	 (file+headline "~/uni/weekly/w%^{week}.org" "Week %^{week}")
	 "*Week %^{week}\n** COMP10120\n** COMP11120\n** COMP12111\n** COMP15111\n** 16321"
	 :jump-to-captured t
	 :empty-lines-after 1
	 )
	)
      )

;; Org Style
(setq org-hide-leading-stars t
      org-hide-emphasis-markers t)

(use-package org-modern
  :config
  (setq org-modern-star nil)
  :init
  (add-hook 'org-mode-hook #'org-modern-mode)
  (add-hook 'org-agenda-finalize-hook #'org-modern-agenda))

;(setq org-pretty-entities nil
;      org-hide-emphasis-markers t)

;; Org Settings
(setq org-M-RET-may-split-line nil)

;;(add-hook 'org-mode-hook 'org-indent-mode)
(setq org-startup-indented t)
(add-hook 'org-mode-hook 'visual-line-mode)


;; Org Tables
;; (load 'org-table-live-update)
;; (require 'org-table-auto-align-mode)

;;;;;;;;;;;;;;;;;
;; Org Preview ;;
;;;;;;;;;;;;;;;;;

;; Formatting preview
(use-package org-appear)

(setq org-appear-autolinks t)
(add-hook 'org-mode-hook 'org-appear-mode)

;; Latex preview
(use-package org-fragtog)

(defun latex-preview-toggle ()
  (org-fragtog-mode)
  (org-latex-preview '(16)))

(add-hook 'org-mode-hook 'latex-preview-toggle)
(setq org-latex-image-default-scale 1)

;; Org LaTeX
(setq org-latex-packages-alist '())
;; (add-to-list 'org-latex-packages-alist '("" "tikz" t))
;; (add-to-list 'org-latex-packages-alist '("" "pgfplots" t))
;; (add-to-list 'org-latex-packages-alist '("" "mathtool" t))
(setq org-latex-create-formula-image-program 'imagemagick)

;; Org Exporting
(setq org-export-with-section-numbers nil)

;; Org Download
(use-package org-download)
(require 'org-download)


;;;;;;;;;;;;;;;;;;;;;;;;;
;; Evil + Org settings ;;
;;;;;;;;;;;;;;;;;;;;;;;;;

(evil-define-key 'normal org-mode-map (kbd "<tab>") #'org-cycle)

;; Enter insert mode after inserting heading in normal mode
(evil-define-key 'normal org-mode-map (kbd "C-<return>")
  #'(lambda () (interactive) (org-insert-heading-respect-content) (evil-append 1)))
(evil-define-key 'normal org-mode-map (kbd "C-S-<return>")
  #'(lambda () (interactive)
      (org-insert-todo-heading-respect-content 1) (evil-append 1)))

(evil-define-key 'normal org-mode-map (kbd "M-<return>")
  #'(lambda () (interactive) (org-meta-return) (evil-append 1)))
(evil-define-key 'normal org-mode-map (kbd "M-S-<return>")
  #'(lambda () (interactive)
      (org-insert-todo-heading 1) (evil-append 1)))

;;;;;;;;;;;;;;;;;;;;
;; Colour Schemes ;;
;;;;;;;;;;;;;;;;;;;;
(use-package gruvbox-theme)

(load-theme 'gruvbox-dark-hard t)

;; Overrides
;;(color-theme-initialize)
;;(color-theme-billw)

(custom-set-faces `(line-number ((t (:background ,(face-background 'default nil t)))))
		  `(line-number-current-line ((t (:background ,(face-background 'default nil t))))))

;; Invert TODO highlighting
;(custom-set-faces `(org-todo ((t (:background ,(face-foreground 'org-todo) :foreground ,(face-background 'default))))))


;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Custom Set Variables ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq custom-file (locate-user-emacs-file "custom.el"))
(load custom-file 'noerror 'nomessage)
