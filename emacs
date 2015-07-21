;;; dotfile --- jeff's .emacs
;;; Commentary:
;;; Code:
(add-to-list 'load-path "~/.emacs.d/site-lisp")
(add-to-list 'load-path "~/.emacs.d/vendor")
(add-to-list 'load-path "~/.emacs.d/vendor/coffee-mode")
(add-to-list 'load-path "~/.emacs.d/vendor/evil")
(require 'package)
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "https://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.org/packages/")))
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

;; helm
(require 'helm-config)
(helm-mode)
;; helm key rebinds
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "C-x b") 'helm-buffers-list)
(global-set-key (kbd "M-x") 'helm-M-x)

;; projectile init
(projectile-global-mode)

(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(defun my-generate-tab-stops (&optional width max)
  "Return a sequence suitable for `tab-stop-list'."
  (let* ((max-column (or max 200))
         (tab-width (or width tab-width))
         (count (/ max-column tab-width)))
    (number-sequence tab-width (* tab-width count) tab-width)))
(setq tab-width 4)
(setq tab-stop-list (my-generate-tab-stops))
(setq c-indent-level 4)
(setq c-default-style "linux"
      c-basic-offset 4)
(setq-default indent-tabs-mode nil)
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
;(add-to-list 'auto-mode-alist '("\\.rs\\'" . auto-complete-mode))
(autoload 'rust-mode "rust-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.rs\\'" . rust-mode))
(setq auto-mode-alist
      (append '(("\\.cs$" . csharp-mode)) auto-mode-alist))
(setq ac-show-menu t)

;; racer
;(setq racer-rust-src-path "/Users/jeff/src/rust/src/")
;(setq racer-cmd "/Users/jeff/src/racer/target/release/racer")
;(add-to-list 'load-path "/Users/jeff/src/racer/editors")
;(eval-after-load "rust-mode" '(require 'racer))

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
    (require 'powershell)
    ;(require 'csharp-mode)
    (load-theme 'railscasts t)
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
    (set-default-font "Inconsolata-14")
    (load-theme 'railscasts t)
    ;(load-theme 'leuven t)
    ;(require 'cask "~/.cask/cask.el")
    ;(cask-initialize)
    (add-hook 'after-init-hook #'global-flycheck-mode)
    (set-cursor-color "red")
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
  ;;(define-key c-mode-base-map (kbd "<C-tab>") 'ac-complete-semantic)
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

;; omnisharp setup
(add-hook 'csharp-mode-hook 'omnisharp-mode)
(setq omnisharp-imenu-support t)

;; this is a function that runs the build command, based on the platform
(defun csharp-build-command ()
  (when (string= "w32" window-system)
  (when (not (string= "w32" window-system))
    (omnisharp-build-in-emacs)
    )))
;; evil/omnisharp setup
(evil-define-key 'insert omnisharp-mode-map (kbd "M-.") 'omnisharp-auto-complete)
(evil-define-key 'normal omnisharp-mode-map (kbd "<f12>") 'omnisharp-go-to-definition)
(evil-define-key 'normal omnisharp-mode-map (kbd "g u") 'omnisharp-helm-find-usages)
(evil-define-key 'normal omnisharp-mode-map (kbd "g s") 'omnisharp-helm-find-symbols)
(evil-define-key 'normal omnisharp-mode-map (kbd "g I") 'omnisharp-find-implementations) ; g i is taken
(evil-define-key 'normal omnisharp-mode-map (kbd "g o") 'omnisharp-go-to-definition)
(evil-define-key 'normal omnisharp-mode-map (kbd "g r") 'omnisharp-run-code-action-refactoring)
(evil-define-key 'normal omnisharp-mode-map (kbd "g f") 'omnisharp-fix-code-issue-at-point)
(evil-define-key 'normal omnisharp-mode-map (kbd "g F") 'omnisharp-fix-usings)
(evil-define-key 'normal omnisharp-mode-map (kbd "g R") 'omnisharp-rename)
(evil-define-key 'normal omnisharp-mode-map (kbd ", i") 'omnisharp-current-type-information)
(evil-define-key 'normal omnisharp-mode-map (kbd ", I") 'omnisharp-current-type-documentation)
(evil-define-key 'insert omnisharp-mode-map (kbd ".") 'omnisharp-add-dot-and-auto-complete)
(evil-define-key 'normal omnisharp-mode-map (kbd ", n t") 'omnisharp-navigate-to-current-file-member)
(evil-define-key 'normal omnisharp-mode-map (kbd ", n s") 'omnisharp-navigate-to-solution-member)
(evil-define-key 'normal omnishlrp-mode-map (kbd ", n f") 'omnisharp-navigate-to-solution-file-then-file-member)
(evil-define-key 'normal omnisharp-mode-map (kbd ", n F") 'omnisharp-navigate-to-solution-file)
(evil-define-key 'normal omnisharp-mode-map (kbd ", n r") 'omnisharp-navigate-to-region)
(evil-define-key 'normal omnisharp-mode-map (kbd "<f12>") 'omnisharp-show-last-auto-complete-result)
(evil-define-key 'insert omnisharp-mode-map (kbd "<f12>") 'omnisharp-show-last-auto-complete-result)
(evil-define-key 'normal omnisharp-mode-map (kbd ",.") 'omnisharp-show-overloads-at-point)
(evil-define-key 'normal omnisharp-mode-map (kbd ",rl") 'omnisharp-build-in-emacs)
(evil-define-key 'normal omnisharp-mode-map (kbd ",ta") 'omnisharp-unit-test-all)
(evil-define-key 'normal omnisharp-mode-map (kbd ",tf") 'omnisharp-unit-test-fixture)
(evil-define-key 'normal omnisharp-mode-map (kbd ",ts") 'omnisharp-unit-test-single)
(evil-define-key 'normal omnisharp-mode-map (kbd ",f") 'helm-projectile)

(evil-define-key 'normal omnisharp-mode-map (kbd ",rt")
  (lambda() (interactive) (omnisharp-unit-test "single")))

(evil-define-key 'normal omnisharp-mode-map
  (kbd ",rf")
  (lambda() (interactive) (omnisharp-unit-test "fixture")))

(evil-define-key 'normal omnisharp-mode-map
  (kbd ",ra")
  (lambda() (interactive) (omnisharp-unit-test "all")))

;; Speed up auto-complete on mono drastically. This comes with the
;; downside that documentation is impossible to fetch.
(setq omnisharp-auto-complete-want-documentation nil)

;; jj to exit insert mode in evil
(define-key evil-insert-state-map (kbd "C-j C-j") 'evil-normal-state)

;; Other misc. keybinds
(define-key evil-normal-state-map (kbd ",f") 'helm-projectile)
(global-set-key (kbd "C--") 'pop-tag-mark)

;; replace emacs window next stuff w/ whats in evil
(global-set-key (kbd "C-x o") 'evil-window-next)
(global-set-key (kbd "C-x n") 'evil-window-next)
(global-set-key (kbd "C-x p") 'evil-window-prev)

;; auto-revert
(global-auto-revert-mode t)

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
 '(ansi-color-faces-vector
   [default bold shadow italic underline bold bold-italic bold])
 '(ansi-color-names-vector
   (vector "#839496" "#dc322f" "#859900" "#b58900" "#268bd2" "#d33682" "#2aa198" "#002b36"))
 '(custom-safe-themes
   (quote
    ("9e7e1bd71ca102fcfc2646520bb2f25203544e7cc464a30c1cbd1385c65898f4" "4cf3221feff536e2b3385209e9b9dc4c2e0818a69a1cdb4b522756bcdf4e00a4" "4aee8551b53a43a883cb0b7f3255d6859d766b6c5e14bcb01bed572fcbef4328" "f0a99f53cbf7b004ba0c1760aa14fd70f2eabafe4e62a2b3cf5cabae8203113b" "86adc18aa6fb3ea0a801831f7b0bc88ed5999386" default)))
 '(fci-rule-color "#073642")
 '(org-agenda-files nil)
 '(safe-local-variable-values
   (quote
    ((eval when
           (fboundp
            (quote rainbow-mode))
           (rainbow-mode 1))
     (buffer-file-coding-system . utf-8-unix))))
 '(vc-annotate-background nil)
 '(vc-annotate-color-map
   (quote
    ((20 . "#dc322f")
     (40 . "#cb4b16")
     (60 . "#b58900")
     (80 . "#859900")
     (100 . "#2aa198")
     (120 . "#268bd2")
     (140 . "#d33682")
     (160 . "#6c71c4")
     (180 . "#dc322f")
     (200 . "#cb4b16")
     (220 . "#b58900")
     (240 . "#859900")
     (260 . "#2aa198")
     (280 . "#268bd2")
     (300 . "#d33682")
     (320 . "#6c71c4")
     (340 . "#dc322f")
     (360 . "#cb4b16"))))
 '(vc-annotate-very-old-color nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(cursor ((t (:background "dark cyan" :foreground "gray100"))))
 '(rainbow-delimiters-depth-1-face ((t (:foreground "red1"))))
 '(rainbow-delimiters-depth-2-face ((t (:foreground "orange1"))))
 '(rainbow-delimiters-depth-3-face ((t (:foreground "yellow1"))))
 '(rainbow-delimiters-depth-4-face ((t (:foreground "green1"))))
 '(rainbow-delimiters-depth-5-face ((t (:foreground "blue1"))))
 '(rainbow-delimiters-depth-6-face ((t (:foreground "magenta1"))))
 '(rainbow-delimiters-depth-7-face ((t (:foreground "purple1"))))
 '(rainbow-delimiters-depth-8-face ((t (:foreground "red1"))))
 '(rainbow-delimiters-depth-9-face ((t (:foreground "orange1"))))
 '(rainbow-delimiters-unmatched-face ((t (:foreground "IndianRed3")))))
(put 'scroll-left 'disabled nil)
