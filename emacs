(add-to-list 'load-path "~/.emacs.d/site-lisp")
(add-to-list 'load-path "~/.emacs.d/vendor")
(add-to-list 'load-path "~/.emacs.d/vendor/coffee-mode")
(add-to-list 'load-path "~/.emacs.d/vendor/evil")
(add-to-list 'load-path "~/.emacs.d/vendor/textmate.el")
(require 'textmate)
(textmate-mode)
(require 'coffee-mode)
(require 'color-theme)
(require 'evil)
(evil-mode 1)
(color-theme-initialize)
(load-file "~/.emacs.d/site-lisp/themes/color-theme-railscasts.el")
(color-theme-railscasts)
(setq-default tab-width 2)

;;; This was installed by package-install.el.
;;; This provides support for the package system and
;;; interfacing with ELPA, the package archive.
;;; Move this code earlier if you want to reference
;;; packages in your .emacs.
(when
		(load
		 (expand-file-name "~/.emacs.d/vendor/package.el"))
	(package-initialize))

;;; Some additional bs to load the marmalade repo
;(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
