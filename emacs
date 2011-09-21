(add-to-list 'load-path "~/.emacs.d/site-lisp")
(add-to-list 'load-path "~/.emacs.d/vendor")
(add-to-list 'load-path "~/.emacs.d/vendor/coffee-mode")
(add-to-list 'load-path "~/.emacs.d/vendor/evil")
(require 'coffee-mode)

;; EVIL vim for emacs stuff
(require 'evil)
(evil-mode 1)

;; old color theme stuff
;(require 'color-theme)
;(color-theme-initialize)
;(load-file "~/.emacs.d/site-lisp/themes/color-theme-railscasts.el")
;(color-theme-railscasts)
(require 'color-theme)
(defun load-color-theme ()
	(when (string= "w32" window-system)
	    	;; if we're on windows, use the old color theme stuff
		(require 'color-theme)
		(color-theme-initialize)
		(load-file "~/.emacs.d/site-lisp/themes/color-theme-railscasts.el")
		(color-theme-railscasts))
	(when (not (string= "w32" window-system))
		;; otherwise we're hopefully running emacs-snapshot, so let's use
		;; the new system
		(load-powershell-if-on-windows)
		(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
		(load-theme 'zenburn)))
(load-color-theme)

(setq-default tab-width 2)

;;; Some additional bs to load the marmalade repo
;(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))

;; save/restore desktop
(desktop-save-mode 1)

;; recentf, weeeee!
(require 'recentf)
(recentf-mode 1)

;; get rid of that confounded toolbar
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))

;; org-mode
(require 'org-install)
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)
(setq org-agenda-files (list "~/Dropbox/org/sugs.org"
                             "~/Dropbox/org/mh.org" 
                             "~/Dropbox/org/work.org" 
                             "~/Dropbox/org/adept.org" 
                             "~/Dropbox/org/personal.org"))

;; ... dropbox stuff..
;; Set to the location of your Org files on your local system
(setq org-directory "~/Dropbox/org") 
;; Set to the name of the file where new notes will be stored
(setq org-mobile-inbox-for-pull "~/Dropbox/org/flagged.org") 
;; Set to <your Dropbox root directory>/MobileOrg.
(setq org-mobile-directory "~/Dropbox/MobileOrg") 

;; powershell on windows
(defun load-powershell-if-on-windows ()
	(if (string= "w32" window-system)
			(require 'powershell)))
(load-powershell-if-on-windows)

;; monky - magit-like hg support
(add-to-list 'load-path "~/.emacs.d/vendor/monky")
(require 'monky)

;; cedet
(load-file "~/.emacs.d/cedet/common/cedet.el")
(semantic-load-enable-excessive-code-helpers)
(require 'semantic-ia)
(require 'semantic-gcc)

;; auto-complete-mode
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/vendor//ac-dict")
(ac-config-default)
(add-to-list 'ac-modes 'coffee-mode)
(add-to-list 'ac-sources 'ac-source-semantic)
(setq ac-show-menu-immediately-on-auto-complete t)
(setq ac-auto-show-menu 1)

;; speedbar config
(require 'sr-speedbar)
(global-set-key (kbd "s-s") 'sr-speedbar-toggle)
(setq sr-speedbar-auto-refresh t)
(setq sr-speedbar-right-side nil)
;; use semantic in speedbar	
(add-hook 'speedbar-load-hook (lambda () (require 'semantic-sb)))

;; some useful c++ dev stuff
(defun my-c-mode-common-hook ()
  (define-key c-mode-base-map (kbd "M-o") 'eassist-switch-h-cpp)
  (define-key c-mode-base-map (kbd "M-m") 'eassist-list-methods)
  (define-key c-mode-base-map (kbd "<C-tab>") 'ac-complete-semantic)
  (define-key c-mode-base-map (kbd "C-.") 'semantic-ia-fast-jump))
(add-hook 'c-mode-common-hook 'my-c-mode-common-hook)

;; load up my ede projects
;(load-file "~/src/sugs/src/sugs-core/sugs-core-ede-proj.el")

;; markdown support
(autoload 'markdown-mode "markdown-mode.el"
   "Major mode for editing Markdown files" t)
(setq auto-mode-alist
   (cons '("\\.md" . markdown-mode) auto-mode-alist))

;###################################
;###################################
;##
;## AUTO ADD BY TOOLING BELOW HERE
;##
;###################################
;###################################

;;; This was installed by package-install.el.
;;; This provides support for the package system and
;;; interfacing with ELPA, the package archive.
;;; Move this code earlier if you want to reference
;;; packages in your .emacs.
(when
		(load
		 (expand-file-name "~/.emacs.d/vendor/package.el"))
	(package-initialize))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes (quote ("86adc18aa6fb3ea0a801831f7b0bc88ed5999386" default))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
