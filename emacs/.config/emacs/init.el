;; Show startup time
(add-hook 'emacs-startup-hook
	  (lambda()
	    (message "Emacs loaded in %s"
		     (format "%.2f seconds"
			     (string-to-number (emacs-init-time))))))

;; straight setup
(make-directory "~/.local/share/emacs" :parents)
(setq straight-base-dir "~/.local/share/emacs"
      straight-use-package-by-default t
      straight-process-buffer " "
      straight-check-for-modifications '(check-on-save))
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

;; Load profiling
(use-package esup
  :ensure t
  :config (setq esup-depth 0))

(use-package free-keys)

;; Immediate evil mode
(use-package evil
  :ensure t
  :config
  (setq evil-undo-system 'undo-redo)
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
  ;; Enable evil
  (evil-mode 1))

;;;;;;;;;;;;;;;;;;;;;;;;;
;; Custom startup page ;;
;;;;;;;;;;;;;;;;;;;;;;;;;
(if (file-exists-p "~/.config/emacs/startupImage")
    (setq fancy-splash-image "~/.config/emacs/startupImage"))

;; (setq fancy-startup-text ((:face variable-pitch "Welcome to buffalo, an emacs configuration for sinners...")))

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

(set-frame-font "FragmentMono 13" nil t)

; Modeline
;(use-package nano-modeline
;  :init
;  (add-hook 'prog-mode-hook        #'nano-modeline-prog-mode)
;  (add-hook 'text-mode-hook        #'nano-modeline-text-mode)
;  (add-hook 'org-mode-hook         #'nano-modeline-org-mode)
;  (add-hook 'org-capture-mode-hook #'nano-modeline-org-capture-mode)
;  (add-hook 'org-agenda-mode-hook  #'nano-modeline-org-agenda-mode)
;  ;(nano-modeline-text-mode t)
;  )

;; Remove cursor blinking
(if (window-system)
    (blink-cursor-mode 0)
  (setq visible-cursor nil))

;; Line numbers
(setq line-number-mode 'nil) ; Hide in modeline
(global-display-line-numbers-mode 1)
(setq display-line-numbers-type 'visual
      display-line-numbers-grow-only t
      display-line-numbers-offset 1)

;; Minibuffer
(setq read-buffer-completion-ignore-case t)

(use-package vertico
  :init
  (vertico-mode 1))

(use-package marginalia
  :after vertico
  :config
  (setq marginalia-align 'right)
  (add-hook 'icomplete-minibuffer-setup-hook
	    (lambda () (setq truncate-lines t)))
  :init
  (marginalia-mode 1))

(use-package solaire-mode
  :init
  (solaire-global-mode 1))

;;;;;;;;;
;; Org ;;
;;;;;;;;;
(use-package org
  ;;:mode (("\\.org$" . org-mode))
  :defer nil
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
	 ("M-C-L" . org-metaright))
  :init
  (setq org-preview-latex-image-directory "~/.local/share/emacs/ltximg/")
  :config
  (setq org-M-RET-may-split-line nil)
  (evil-define-key 'normal org-mode-map (kbd "<tab>") #'org-cycle)
  ;; Enter insert mode after inserting heading in normal mode
  (evil-define-key 'normal org-mode-map (kbd "C-<return>")
    #'(lambda () (interactive) (org-insert-heading-respect-content) (evil-append 1)))
  (evil-define-key 'normal org-mode-map (kbd "C-S-<return>")
    #'(lambda () (interactive) (org-insert-todo-heading-respect-content 1) (evil-append 1)))
  (evil-define-key 'normal org-mode-map (kbd "M-<return>")
    #'(lambda () (interactive) (org-meta-return) (evil-append 1)))
  (evil-define-key 'normal org-mode-map (kbd "M-S-<return>")
    #'(lambda () (interactive) (org-insert-todo-heading 1) (evil-append 1)))
  ;; Image preview
  (setq org-latex-image-default-scale 1)
  ;; LaTeX Fragments
  (setq org-latex-packages-alist '())
  (setq org-preview-latex-default-process 'imagemagick)
  (setq org-startup-with-latex-preview t)
  ;; Exporting
  (setq org-export-with-section-numbers nil)
  (setq org-startup-indented t)
  (add-hook 'org-mode-hook 'visual-line-mode)
  ;; Tables
  (load "org-table-live-update")
  (org-table-auto-align-mode 1)
  ;; Capture
  (defun promptForWeek () (interactive)
	 (read-string "Week number: "))
  (setq org-capture-templates
	'(("w" "Weekly" entry
	   (file+headline "~/uni/weekly/w%^{week}.org" "Week %^{week}")
	   "*Week %^{week}\n** COMP10120\n** COMP11120\n** COMP12111\n** COMP15111\n** 16321"
	   :jump-to-captured t
	   :empty-lines-after 1))))



(use-package org-modern
  :hook org-mode-hook
  :config
  (setq org-modern-star     nil
	org-modern-progress nil
	org-modern-table    nil)
  (setq org-modern-label-border 0)
  :init
  (add-hook 'org-mode-hook #'org-modern-mode)
  (add-hook 'org-agenda-finalize-hook #'org-modern-agenda))

(use-package org-modern-indent
  :hook org-mode-hook
  :straight (org-modern-indent :type git :host github :repo "jdtsmith/org-modern-indent")
  :init
  (add-hook 'org-mode-hook #'org-modern-indent-mode)
  )

;; Hide verbatim symbols
(use-package org-appear
  :hook org-mode-hook
  :config
  (setq org-appear-autolinks t)
  :init
  (add-hook 'org-mode-hook 'org-appear-mode))


;; Auto LaTeX preview
(use-package org-fragtog
  :hook org-modern-mode-hook
  :init
  ;(defun latex-preview-toggle () (org-fragtog-mode 1) (org-latex-preview '(16)))
  (add-hook 'org-mode-hook 'org-fragtog-mode))

;; Org Download
(use-package org-download
  :hook org-mode-hook
  :config
  (require 'org-download))


;;;;;;;;;;;;;;;;;;;;
;; Colour Schemes ;;
;;;;;;;;;;;;;;;;;;;;
(use-package gruvbox-theme
  :init
  (load-theme 'gruvbox-dark-hard t))

;; Overrides
(custom-set-faces `(line-number ((t (:background ,(face-background 'default nil t)))))
		  `(line-number-current-line ((t (:background ,(face-background 'default nil t))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Custom Set Variables ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq custom-file (locate-user-emacs-file "custom.el"))
(load custom-file 'noerror 'nomessage)
