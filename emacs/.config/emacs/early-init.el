;; Plugins
(setq package-enable-at-startup nil)
;(setq use-package-verbose t
;      use-package-minimum-reported-time 0)

;; Move eln-cache
;; Set eln-cache dir
(when (boundp 'native-comp-eln-load-path)
  (startup-redirect-eln-cache (expand-file-name "~/.cache/eln-cache/" user-emacs-directory)))

;; UI
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(setq initial-scratch-message "")


;; Load paths
(add-to-list 'load-path (expand-file-name "elisp" user-emacs-directory))

;; Custom paths
(defvar package-source-directory "~/.local/share/emacs")
(setq bookmark-default-file "~/.local/share/emacs"
	  package-user-dir (expand-file-name package-source-directory "elpa"))
(when (boundp 'native-comp-eln-load-path)
  (startup-redirect-eln-cache "~/.cache/emacs/eln-cache"))
