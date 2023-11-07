;; Custom startup page
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
(setq mode-require-final-newline nil)

;; Clipboard
(global-set-key (kbd "C-V") 'clipboard-yank)
(global-set-key (kbd "C-C") 'clipboard-kill-ring-save)

;; Backups
(make-directory "~/backups/emacs" :parents)
(setq backup-directory-alist '(("." . "~/backups/emacs"))
      backup-by-copying t)

;; UI changes
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)

;; Themes/Visuals
(set-frame-font "Terminus 14" nil t)

;; Modeline

;; Packages
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


;; Org
(unless (package-installed-p 'org)
  (package-install 'org))

(setq org-hide-leading-stars t
      org-hide-emphasis-markers t)

(setq org-M-RET-may-split-line nil)

(add-hook 'org-mode-hook 'org-indent-mode)
(add-hook 'org-mode-hook 'visual-line-mode)


;; Org Tables
;; (load 'org-table-live-update)
;; (require 'org-table-auto-align-mode)


;; Org Appear
(unless (package-installed-p 'org-appear)
  (package-install 'org-appear))

(add-hook 'org-mode-hook 'org-appear-mode)


;; Org Fragtog
(unless (package-installed-p 'org-fragtog)
  (package-install 'org-fragtog))

(defun latex-preview-toggle ()
  (org-fragtog-mode)
  (org-latex-preview '(16)))

(add-hook 'org-mode-hook 'latex-preview-toggle)


;; Org LaTeX
(setq org-latex-packages-alist '())
;; (add-to-list 'org-latex-packages-alist '("" "tikz" t))
;; (add-to-list 'org-latex-packages-alist '("" "pgfplots" t))
;; (add-to-list 'org-latex-packages-alist '("" "mathtool" t))
(setq org-latex-create-formula-image-program 'imagemagick)


;; Org Exporting
(setq org-export-with-section-numbers nil)


;; Evil + Org settings

(evil-define-key 'normal org-mode-map (kbd "<tab>") #'org-cycle)

;; Colour Schemes
(unless (package-installed-p 'nano-theme)
  (package-install 'nano-theme))

(unless (package-installed-p 'gruvbox-theme)
  (package-install 'gruvbox-theme))

(load-theme 'gruvbox-dark-hard t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("1781e8bccbd8869472c09b744899ff4174d23e4f7517b8a6c721100288311fa5" default))
 '(evil-undo-system 'undo-redo)
 '(org-agenda-files
   '("~/uni/weekly/w5.org" "/home/noah/uni/weekly/w4.org" "/home/noah/todo.org"))
 '(org-format-latex-options
   '(:foreground default :background default :scale 2.0 :html-foreground "Black" :html-background "Transparent" :html-scale 1.0 :matchers
		 ("begin" "$1" "$" "$$" "\\(" "\\[")))
 '(package-selected-packages '(gruvbox-theme org-fragtog org-appear evil)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
