;;;;;;;;;;;;;;;;;;;;;;;;;
;; Custom startup page ;;
;;;;;;;;;;;;;;;;;;;;;;;;;
(if (file-exists-p "~/.config/emacs/startupImage")
    (setq fancy-splash-image "~/.config/emacs/startupImage"))

;; (setq fancy-startup-text ((:face variable-pitch "Welcome to buffalo, an emacs configuration for sinners...")))

;; Disable startup nonsense
(setq-default message-log-max nil)
;;(setq initial-scratch-message ""
;;      inhibit-startup-message t)

;; Load paths
(add-to-list 'load-path (expand-file-name "elisp" user-emacs-directory))

;; Behavior
(save-place-mode 1)
(global-auto-revert-mode 1)
(recentf-mode 1)
(setq use-dialog-box nil)

;; Clipboard
(global-set-key (kbd "C-V") 'clipboard-yank)
(global-set-key (kbd "C-C") 'clipboard-kill-ring-save)

;; Backups
(make-directory "~/backups/emacs" :parents)
(setq backup-directory-alist '(("." . "~/backups/emacs"))
      backup-by-copying t)

;;;;;;;;;;;;;;;;
;; UI Changes ;;
;;;;;;;;;;;;;;;;
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(pixel-scroll-mode 0)
(pixel-scroll-precision-mode 0)
(setq pixel-scroll-precision-large-scroll-height 40.0)

;; Themes/Visuals
(set-frame-font "FragmentMono 12" nil t)

;; Modeline

;;;;;;;;;;;;;;
;; Packages ;;
;;;;;;;;;;;;;;
(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/"))

(make-directory "~/.local/share/emacs/packages" :parents)
(setq package-user-dir "~/.local/share/emacs/packages")
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; Evil
(unless (package-installed-p 'evil)
  (package-install 'evil))

(setq evil-want-C-u-scroll nil
      evil-want-C-d-scroll nil)

(require 'evil)
(evil-mode 1)

(setq evil-undo-system 'undo-redo)

(global-display-line-numbers-mode 1)

(setq-default display-line-numbers-type 'visual
	      scroll-step 1 ; Vim scrolling
	      scroll-margin 6) ; Scrolloff

;;Move normally on wrapped text
(define-key evil-normal-state-map (kbd "<remap> <evil-next-line>") 'evil-next-visual-line)
(define-key evil-normal-state-map (kbd "<remap> <evil-previous-line>") 'evil-previous-visual-line)
(define-key evil-motion-state-map (kbd "<remap> <evil-next-line>") 'evil-next-visual-line)
(define-key evil-motion-state-map (kbd "<remap> <evil-previous-line>") 'evil-previous-visual-line)


;;;;;;;;;
;; Org ;;
;;;;;;;;;
(unless (package-installed-p 'org)
  (package-install 'org))

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


;; Org Settings
(setq org-hide-leading-stars t
      org-hide-emphasis-markers t)

(setq org-M-RET-may-split-line nil)

(add-hook 'org-mode-hook 'org-indent-mode)
(add-hook 'org-mode-hook 'visual-line-mode)


;; Org Tables
;; (load 'org-table-live-update)
;; (require 'org-table-auto-align-mode)


;;;;;;;;;;;;;;;;;
;; Org Preview ;;
;;;;;;;;;;;;;;;;;

;; Formatting preview
(unless (package-installed-p 'org-appear)
  (package-install 'org-appear))

(setq org-appear-autolinks t)
(add-hook 'org-mode-hook 'org-appear-mode)

;; Latex preview
(unless (package-installed-p 'org-fragtog)
  (package-install 'org-fragtog))

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
(unless (package-installed-p 'org-download)
  (package-install 'org-download))

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

;; Heading Movement
(evil-define-key 'normal org-mode-map (kbd "M-j") #'org-metadown)
(evil-define-key 'normal org-mode-map (kbd "M-k") #'org-metaup)

;; Heading Indentation
(evil-define-key 'normal org-mode-map (kbd "M-l") #'org-shiftmetaright)
(evil-define-key 'normal org-mode-map (kbd "M-h") #'org-shiftmetaleft)
(evil-define-key 'normal org-mode-map (kbd "M-L") #'org-metaright)
(evil-define-key 'normal org-mode-map (kbd "M-H") #'org-metaleft)

;; Heading Navigation
(evil-define-key 'normal org-mode-map (kbd "M-H") #'org-shiftmetaleft)

;;;;;;;;;;;;;;;;;;;;
;; Colour Schemes ;;
;;;;;;;;;;;;;;;;;;;;
(unless (package-installed-p 'nano-theme)
  (package-install 'nano-theme))

(unless (package-installed-p 'gruvbox-theme)
  (package-install 'gruvbox-theme))

(load-theme 'gruvbox-dark-hard t)

;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Custom Set Variables ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq custom-file (locate-user-emacs-file "custom.el"))
(load custom-file 'noerror 'nomessage)
