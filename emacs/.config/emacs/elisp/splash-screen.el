(require 'subr-x)
(require 'cl-lib)


(defgroup splash-screen nil
  "Splash screen")

(defcustom splash-screen-title "GNU Emacs"
  "Splash screen title"
  :type 'string :group 'splash-screen)

(defcustom splash-screen-subtitle "2024"
  "Splash screen subtitle"
  :type 'string :group 'splash-screen)

(defun splash-screen ()
  "Nano Emacs splash screen"
  (remove-hook 'window-setup-hook #'splash-screen)

  ;; Hide modeline before window-body-height is computed
  (let* ((splash-buffer (get-buffer-create "*splash*")))
    (with-current-buffer splash-buffer
      (setq header-line-format nil)
      (setq mode-line-format nil)
      (setq cursor-type nil)
      (if (fboundp 'evil-mode)
	  (setq-local evil-normal-state-cursor nil)
	  (setq-local evil-emacs-state-cursor nil)
	(setq-local cursor-type nil))
      (display-line-numbers-mode 0)))
  
  (let* ((splash-buffer  (get-buffer-create "*splash*"))
         (height         (round (- (window-total-height nil) 1) ))
         (width          (round (window-total-width nil)        ))
         (padding-center (+ (/ height 2) 1)))
    
    ;; If there are buffer associated with filenames,
    ;;  we don't show the splash screen.
    (if (eq 0 (length (cl-loop for buf in (buffer-list)
                              if (buffer-file-name buf)
                              collect (buffer-file-name buf))))
        
        (with-current-buffer splash-buffer
          (erase-buffer)
          
          ;; Buffer local settings
          (if (one-window-p) (setq mode-line-format nil))
          (setq cursor-type nil)
          (setq line-spacing 0)
          (setq vertical-scroll-bar nil)
          (setq horizontal-scroll-bar nil)
          (setq fill-column width)
          (face-remap-add-relative 'link :underline nil)
          (if (not (display-graphic-p)) (menu-bar-mode 0))

          ;; Vertical padding to center
          (insert-char ?\n padding-center)
          (insert (propertize splash-screen-title 'face 'default))
          (center-line)
          (insert "\n")
          (insert (propertize splash-screen-subtitle 'face 'shadow))
          (center-line)

          (goto-char 0)
          (read-only-mode 1)
          (display-buffer-same-window splash-buffer nil)

	  (message "")
	  (add-hook 'window-state-change-hook #'recenter-or-kill nil t)
	  (setq cursor-type nil)
	  )
      (splash-screen-kill)))

  )


(defun center-string (string)
  "Pad a string with space on the left such as to center it"
  (let* ((padding (/ (- (window-body-width) (length string)) 2))
         (padding (+ (length string) padding)))
    ;; If the string is displayed as a tooltip, don't pad it
    (if (and tooltip-mode (fboundp 'x-show-tip))
        string
      (format (format "%%%ds" padding) string))))

(defun recenter-or-kill ()
  "Recenter the splash screen or kill it if no longer visible"
  (if (not (get-buffer-window "*splash*"))
      (progn (remove-hook 'window-state-change-hook #'recenter-or-kill t)
	     (message "Hook removed")
	     (kill-buffer "*splash*")
	     (message "Buffer killed")
	     )
    (splash-screen-recenter)
    )
  )

(defun splash-screen-recenter ()
  "Recenter splash screen"
  (let* ((splash-buffer  (get-buffer-create "*splash*"))
         (height         (round (- (window-body-height (get-buffer-window splash-buffer)) 3) ))
         (width          (round (window-body-width (get-buffer-window splash-buffer))        ))
         (padding-center (+ (/ height 2) 1)))
  (with-current-buffer splash-buffer
    (read-only-mode -1)
    (erase-buffer)

    (setq fill-column width)
    
    ;; Vertical padding to center
    (insert-char ?\n padding-center)
    (insert (propertize splash-screen-title 'face 'default))
    (center-line)
    (insert "\n")
    (insert (propertize (concat "v" (number-to-string emacs-major-version) "." (number-to-string emacs-minor-version)) 'face 'shadow))
    (center-line)

    (goto-char 0)
    (read-only-mode 1)
    (setq cursor-type nil)

    ))
  )

(defun splash-screen-kill ()
  "Kill the splash screen buffer (immediately)."
  (if (get-buffer "*splash*")
      (progn (message nil)
             (kill-buffer "*splash*"))))


;; Install hook after frame parameters have been applied and only if
;; no option on the command line
(if (and (not (member "-no-splash"  command-line-args))
         (not (member "--file"      command-line-args))
         (not (member "--insert"    command-line-args))
         (not (member "--find-file" command-line-args))
         )
    (progn
      (add-hook 'window-setup-hook #'splash-screen)
      (put 'inhibit-startup-echo-area-message 'saved-value
	   (setq inhibit-startup-echo-area-message (user-login-name)))
      (setq 
	    ;inhibit-startup-echo-area-message (user-login-name) ; I hate you Richard Stallman
	    inhibit-startup-screen t 
            inhibit-startup-message t
	    )))

(provide 'splash-screen)
