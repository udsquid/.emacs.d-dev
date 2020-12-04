;; set 'command' as META key, 'option/alt' as SUPER key
(setq mac-command-modifier 'meta)
(setq mac-option-modifier 'super)

;; switch 'C-x' & 'C-t' keys
(keyboard-translate ?\C-x ?\C-t)
(keyboard-translate ?\C-t ?\C-x)

;; quick switch between two recent buffers
(fset 'quick-switch-buffer [?\C-x ?b return])
(global-set-key (kbd "s-f") 'quick-switch-buffer)

;; setup package repository
;; copy from: https://melpa.org/#/getting-started
(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  (when no-ssl (warn "\
Your version of Emacs does not support SSL connections,
which is unsafe because it allows man-in-the-middle attacks.
There are two things you can do about this warning:
1. Install an Emacs version that does support SSL and be safe.
2. Remove this warning from your init file so you won't see it again."))
  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
  ;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
  ;; and `package-pinned-packages`. Most users will not need or want to do this.
  ;;(add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
  )
(package-initialize)

;; install 'use-package', a package to tidy up your package configurations
(if (not (package-installed-p 'use-package))
    (progn
      (package-refresh-contents)
      (package-install 'use-package)))

(require 'use-package)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(expand-region helm helpful avy cyberpunk-theme use-package)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; setup theme
(use-package cyberpunk-theme
  :ensure t
  :init
  (load-theme 'cyberpunk t))

;; turn off any window widgets
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

;; setup font
(add-to-list 'default-frame-alist '(font . "DejaVu Sans Mono-16"))

;; cursor jumping package
(use-package avy
  :ensure t
  :bind ("M-o" . avy-goto-char))

;; highlight current line
(global-hl-line-mode t)

;; show column number
(setq column-number-mode t)

;; better help system
(use-package helpful
  :ensure t
  :bind (("C-h f" . helpful-callable)
	 ("C-h v" . helpful-variable)
	 ("C-h k" . helpful-key)))

;; powerful search framework
(use-package helm
  :ensure t
  :bind (("M-x" . helm-M-x)
	 ([remap find-file] . helm-find-files))
  :config
  (helm-mode t))

;; disable auto save buffer
(setq auto-save-default nil)
;; disable backup file
(setq make-backup-files nil)

;; turn off newbie protection
(put 'narrow-to-region 'disabled nil)

;; move around between windows
(when (fboundp 'windmove-default-keybindings)
  (windmove-default-keybindings))

;; smart select region
(use-package expand-region
  :ensure t
  :bind ("s-h" . er/expand-region))

;; --- handy custom keys ---
;; right-hand for cursor movings
(global-set-key (kbd "M-p") 'backward-paragraph)
(global-set-key (kbd "M-n") 'forward-paragraph)

(global-set-key (kbd "M-i") 'back-to-indentation)

;; left-hand for editing
