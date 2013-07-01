(add-to-list 'load-path "~/.emacs.d/site-lisp")
(add-to-list 'load-path "~/.emacs.d/vendor")
(add-to-list 'load-path "~/.emacs.d/vendor/coffee-mode")
(add-to-list 'load-path "~/.emacs.d/vendor/evil")
(add-to-list 'load-path "~/.emacs.d/vendor/flymake-node-jshint")
(require 'coffee-mode)

;; EVIL vim for emacs stuff
(require 'evil)
(evil-mode 1)
;; exit insert mode w/ ctrl+j
(define-key global-map "\C-j" 'evil-esc)

;; scroll one line at a time
(setq scroll-step 1)

;; window switching w/ start key (loonix only)
(defun jeff-back-window ()
  (interactive)
  (other-window -1))

;; we're hopefully running emacs-snapshot, so let's use
;; the new system
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/solarized")
(load-theme 'zenburn t)

(setq-default tab-width 2)
(setq-default indent-tabs-mode nil)
(setq c-indent-level 2)
(setq c-default-style "linux"
      c-basic-offset 2)
(global-linum-mode 1)
(setq linum-format "%d ")
(defun coffee-custom ()
	"coffee-mode-hook"
	(set (make-local-variable 'tab-width) 2))
(add-hook 'coffee-mode-hook
					'(lambda () (coffee-custom)))
;;; Some additional bs to load the marmalade repo
                                        ;(add-to-list 'package-archives
                                        ;			 '("marmalade" . "http://marmalade-repo.org/packages/"))

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
;;(global-set-key (kbd "<tab>") 'org-cycle)
(setq org-log-done t)
(setq org-agenda-files (list "~/Dropbox/org/personal/"
                             "~/Dropbox/org/ss"
                             "~/Dropbox/org/personal"
                             "~/Dropbox/org/work"))

;; ... dropbox stuff..
;; Set to the location of your Org files on your local system
(setq org-directory "~/Dropbox/org") 
;; Set to the name of the file where new notes will be stored
(setq org-mobile-inbox-for-pull "~/Dropbox/org/flagged.org") 
;; Set to <your Dropbox root directory>/MobileOrg.
(setq org-mobile-directory"~/Dropbox/MobileOrg") 
(setq org-mobile-files (list "~/Dropbox/org/todo.org"
                             "~/Dropbox/org/ss"
                             "~/Dropbox/org/personal"
                             "~/Dropbox/org/work"))

;; monky - magit-like hg support
;;(add-to-list 'load-path "~/.emacs.d/vendor/monky")
;;(require 'monky)

;; cedet
;;(load-file "~/.emacs.d/cedet/common/cedet.el")
;;(semantic-load-enable-excessive-code-helpers)
;;(require 'semantic-ia)
;;(require 'semantic-gcc)

;; rust-mode
(add-to-list 'load-path "~/.emacs.d/vendor/rust")
(require 'rust-mode)
(defun my-rust-mode-hook ()
                                        ;(auto-complete-mode 1)
  )
(add-hook 'rust-mode-hook 'my-rust-mode-hook)

;; auto-complete-mode
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/vendor//ac-dict")
(global-auto-complete-mode t)
(ac-config-default)
(add-to-list 'ac-sources 'ac-source-semantic 'ac-source-words-in-same-mode-buffers)
(setq ac-show-menu-immediately-on-auto-complete t)
(setq ac-auto-show-menu 1)
(add-to-list 'ac-modes 'coffee-mode 'rust-mode)
(add-to-list 'auto-mode-alist '("\\.cpp\\'" . auto-complete-mode))
(add-to-list 'auto-mode-alist '("\\.rust\\'" . auto-complete-mode))

;; buffer-move
(require 'buffer-move)
(global-set-key (kbd "<C-S-up>")     'buf-move-up)
(global-set-key (kbd "<C-S-down>")   'buf-move-down)
(global-set-key (kbd "C-M-[")  (lambda () (interactive)
                                 (progn (buf-move-left)
                                 (other-window 1))))
(global-set-key (kbd "C-M-]")  (lambda () (interactive)
                                 (progn (buf-move-right)
                                 (other-window 1))))

(defun auto-complete-mode-maybe()
  (unless (minibufferp (current-buffer))
    (auto-complete-mode 1)))

(defun org-mobile-push-on-save ()
  (when (and (stringp buffer-file-name)
             (string-match "\\.org$" buffer-file-name))
    (org-mobile-push)))
(add-hook 'after-save-hook 'org-mobile-push-on-save)

(require 'color-theme)
(defun per-platform-setup ()
  (when (string= "w32" window-system)
    (require 'flymake)
    (add-to-list 'load-path "~/.emacs.d/vendor/csharpmode")
    (require 'powershell)
    (require 'csharp-mode)
    (setq auto-mode-alist
          (append '(("\\.cs$" . csharp-mode)) auto-mode-alist))
    (defun my-csharp-mode-fn ()
      ;; should put something here..
      )
    (add-hook  'csharp-mode-hook 'my-csharp-mode-fn t))
  (when (not (string= "w32" window-system))
    ))
(global-set-key (kbd "<s-down>") 'other-window)
(global-set-key (kbd "<s-up>") 'jeff-back-window)
(per-platform-setup)

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


;; markdown support
(autoload 'markdown-mode "markdown-mode.el"
  "Major mode for editing Markdown files" t)
(setq auto-mode-alist
      (cons '("\\.md" . markdown-mode) auto-mode-alist))

;; windows and revive -- cross-session window layout
(require 'windows)
(win:startup-with-window)
(define-key ctl-x-map "C" 'see-you-again)
(autoload 'save-current-configuration "revive" "Save status" t)
(autoload 'resume "revive" "Resume Emacs" t)
(autoload 'wipe "revive" "Wipe Emacs" t)

(define-key ctl-x-map "S" 'save-current-configuration)
(define-key ctl-x-map "F" 'resume)
(define-key ctl-x-map "K" 'wipe)

;; tern / js support
;;(autoload 'tern-mode "tern.el" nil t)
;;(autoload 'tern-mode "tern-auto-complete.el" nil t)
;;(add-hook 'js-mode-hook (lambda () (tern-mode t)))
;;(eval-after-load 'tern
;;  '(progn
;;     (require 'tern-auto-complete)
;;     (tern-ac-setup)))

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
 '(custom-safe-themes (quote ("86adc18aa6fb3ea0a801831f7b0bc88ed5999386" default)))
 '(org-agenda-files nil)
 '(safe-local-variable-values (quote ((buffer-file-coding-system . utf-8-unix)))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'scroll-left 'disabled nil)

;; jshint support
(require 'flymake-node-jshint)
(add-hook 'js-mode-hook (lambda () (flymake-mode 1)))

;; flymake errors in console/tty emacs
(defun next-flymake-error ()
  (interactive)
  (let ((err-buf nil))
    (condition-case err
        (setq err-buf (next-error-find-buffer))
      (error))
    (if err-buf
        (next-error)
      (progn
        (flymake-goto-next-error)
        (let ((err (get-char-property (point) 'help-echo)))
          (when err
            (message err)))))))
