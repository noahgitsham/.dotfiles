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

;;(defvar emacs-data-path "~/.local/share/emacs")
;;(defvar emacs-cache-path "~/.cache/emacs")
;;(defvar emacs-state-path "~/.local/state/emacs")

(defvar emacs-data-path (if (getenv "XDG_DATA_HOME")
			    (expand-file-name "emacs" (getenv "XDG_DATA_HOME"))
			  ("~/.local/share/emacs")))

(defvar emacs-state-path (if (getenv "XDG_STATE_HOME")
			    (expand-file-name "emacs" (getenv "XDG_STATE_HOME"))
			  ("~/.local/state/emacs")))

(defvar emacs-cache-path (if (getenv "XDG_CACHE_HOME")
			    (expand-file-name "emacs" (getenv "XDG_CACHE_HOME"))
			  ("~/.cache/emacs")))

(setq package-user-dir             (expand-file-name "packages" emacs-data-path)
      save-place-file              (expand-file-name "places" emacs-state-path)
      recentf-save-file            (expand-file-name "recentf" emacs-state-path)
      bookmark-default-file        (expand-file-name "bookmarks" emacs-state-path)
      eshell-directory-name        (expand-file-name "eshell" emacs-state-path)
      ido-save-directory-list-file (expand-file-name "ido.last" emacs-state-path)
      tramp-persistency-file-name  (expand-file-name "tramp" emacs-state-path)
      transient-levels-file        (expand-file-name "levels.el" emacs-state-path)
      transient-values-file        (expand-file-name "values.el" emacs-state-path)
      transient-history-file       (expand-file-name "history.el" emacs-state-path)
      auto-save-list-file-prefix   (expand-file-name "autosaves/.saves-" emacs-data-path))

(when (boundp 'native-comp-eln-load-path)
  (startup-redirect-eln-cache (expand-file-name "eln-cache" emacs-cache-path)))
