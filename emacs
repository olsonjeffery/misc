;;; dotfile --- jeff's .emacs
;;; Commentary:
;;; Code:
(add-to-list 'load-path "~/.emacs.d/site-lisp")
(add-to-list 'load-path "~/.emacs.d/vendor")
(add-to-list 'load-path "~/.emacs.d/vendor/coffee-mode")
(add-to-list 'load-path "~/.emacs.d/vendor/evil")
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)

;; EVIL vim for emacs stuff
(require 'evil)
(evil-mode 1)
(setq evil-default-cursor '("#DDDDDD" box))
;; exit insert mode w/ ctrl+j
(define-key global-map "\C-j" 'evil-esc)
(eval-after-load "org" 
  '(progn
    (define-key org-mode-map "\C-j" nil)
    (define-key org-mode-map "\C-j" 'evil-esc)
    (defun my-org-mode-hook ()
      ;; The following two lines of code is run from the mode hook.
      ;; These are for buffer-specific things.
      ;; In this setup, you want to enable flyspell-mode
      ;; and run org-reveal for every org buffer.
      (flyspell-mode 1)
      (org-reveal))
    (add-hook 'org-mode-hook 'my-org-mode-hook)))

;; always enable word wrap
(global-visual-line-mode)

;; scroll one line at a time
(setq scroll-step 1)

;; window switching w/ start key (loonix only)
(defun jeff-back-window ()
  (interactive)
  (other-window -1))

(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
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
(add-to-list 'auto-mode-alist '("\\.rs\\'" . auto-complete-mode))
(add-to-list 'auto-mode-alist '("\\.rs\\'" . rust-mode))
(setq ac-show-menu t)

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
(global-set-key (kbd "C-M-'")  (lambda () (interactive)
                                 (progn (buf-move-down)
                                 (other-window 1))))
(global-set-key (kbd "C-M-=")  (lambda () (interactive)
                                 (progn (buf-move-up)
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
    (load-theme 'railscasts t)
    (setq auto-mode-alist
          (append '(("\\.cs$" . csharp-mode)) auto-mode-alist))
    (defun my-csharp-mode-fn ()
      ;; should put something here..
      )
    (add-hook  'csharp-mode-hook 'my-csharp-mode-fn t))
  (when (string= "x" window-system)
    (set-default-font "Ubuntu Mono-12")
    ;(load-theme 'cyberpunk t)
    ;(load-theme 'monokai t)
    (load-theme 'railscasts t)
    ;(load-theme 'zenburn t)
    (require 'cask "~/.cask/cask.el")
    (cask-initialize)
    (add-hook 'after-init-hook #'global-flycheck-mode)
    )
  (when (string= "ns" window-system)
    (set-default-font "Monaco-12")
    (load-theme 'railscasts t)
    ;(require 'cask "~/.cask/cask.el")
    ;(cask-initialize)
    (add-hook 'after-init-hook #'global-flycheck-mode)
    )
  (when (not (string= "w32" window-system))
    ))
(per-platform-setup)

;; rust-mode
(add-to-list 'load-path "~/.emacs.d/vendor/rust")
(require 'rust-mode)
(defun my-rust-mode-hook ()
                                        ;(auto-complete-mode 1)
  )
(add-hook 'rust-mode-hook 'my-rust-mode-hook)

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
(global-set-key (kbd "C-M-n")  (lambda () (interactive)
                                 (next-flymake-error)))

;###################################
;###################################
;##
;## AUTO ADD BY TOOLING BELOW HERE
;##
;###################################
;###################################

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("f0a99f53cbf7b004ba0c1760aa14fd70f2eabafe4e62a2b3cf5cabae8203113b" "86adc18aa6fb3ea0a801831f7b0bc88ed5999386" default)))
 '(org-agenda-files nil t)
 '(safe-local-variable-values
   (quote
    ((eval when
           (fboundp
            (quote rainbow-mode))
           (rainbow-mode 1))
     (buffer-file-coding-system . utf-8-unix)))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(cursor ((t (:background "#EEEEEE" :foreground "#5A647E")))))
(put 'scroll-left 'disabled nil)
