 
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

;;; ADD REPOSITORIES AND PACKAGES ------------------------------------

;; add melpa and marmalade
(when (>= emacs-major-version 24)
  (require 'package)
  (add-to-list
   'package-archives
   '("melpa" . "http://melpa.org/packages/")
   '("marmalade" . "http://marmalade-rep.org/packages/")))

;; enable  loading of files downloaded manually
(add-to-list
 'load-path "~/.emacs.d/user-download/")

(load "tetris")


;; add slime
(load (expand-file-name "~/quicklisp/slime-helper.el"))
(setq inferior-lisp-program "/usr/bin/sbcl")
(setq slime-contribs '(slime-fancy))

;; add inferior mode for Haskell
(require 'haskell-interactive-mode)
(require 'haskell-process)
(add-hook 'haskell-mode-hook 'interactive-haskell-mode)
;; customize it a bit
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default bold shadow italic underline bold bold-italic bold])
 '(ansi-color-names-vector
   (vector "#839496" "#dc322f" "#859900" "#b58900" "#268bd2" "#d33682" "#2aa198" "#002b36"))
 '(custom-enabled-themes (quote (sanityinc-solarized-dark)))
 '(custom-safe-themes
   (quote
    ("4cf3221feff536e2b3385209e9b9dc4c2e0818a69a1cdb4b522756bcdf4e00a4" "a8245b7cc985a0610d71f9852e9f2767ad1b852c2bdea6f4aadc12cce9c4d6d0" "d91ef4e714f05fff2070da7ca452980999f5361209e679ee988e3c432df24347" "0598c6a29e13e7112cfbc2f523e31927ab7dce56ebb2016b567e1eff6dc1fd4f" "4aee8551b53a43a883cb0b7f3255d6859d766b6c5e14bcb01bed572fcbef4328" default)))
 '(fci-rule-color "#073642")
 '(frame-background-mode (quote dark))
 '(haskell-mode-hook (quote (turn-on-haskell-indentation)))
 '(haskell-process-auto-import-loaded-modules t)
 '(haskell-process-log t)
 '(haskell-process-suggest-remove-import-lines t)
 '(menu-bar-mode nil)
 '(package-archives
   (quote
    (("marmalade" . "http://marmalade-repo.org/packages/")
     ("gnu" . "https://elpa.gnu.org/packages/")
     ("melpa" . "http://melpa.milkbox.net/packages/"))))
 '(package-selected-packages
   (quote
    (tramp color-theme-solarized base16-theme color-theme-sanityinc-solarized yasnippet haskell-mode ipython ghc org 0blayout company slime)))
 '(scroll-bar-mode nil)
 '(tool-bar-mode nil)
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

;; command to always enter auto-completion mode via company
(add-hook 'after-init-hook 'global-company-mode)

;; activate org mode during init
(require 'org)
(define-key global-map "\C-cl" 'org-storage-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)

;; enter into 0blayout mode after init
(add-hook 'after-init-hook '0blayout-mode)

;; add hexview-mode.el
;;(require 'hexview-mode)

;; add yasnippets to type less
(require 'yasnippet)
(yas-global-mode 1)

;; add solarized color theme
(add-to-list 'load-path "/home/user1/.emacs.d/elpa/color-theme-sanityinc-solarized-2.25/")
(require 'color-theme-sanityinc-solarized)
(color-theme-sanityinc-solarized-dark)

;; always enter auto-fill-mode when in latex and other modes
(add-hook 'text-mode-hook
	  (lambda ()
	    (auto-fill-mode)
	    (set-fill-column 80)))

;;; MISCELLANEOUS COMMANDS -------------------------------------------

;; setup tramp mode
(setq tramp-default-method "ssh")

;; provide syntax highlighting for .template files
(setq auto-mode-alist
      (append '((".*\\.template\\'" . c++-mode))
	      auto-mode-alist))

;; automatically indent python code
(add-hook 'python-mode-hook
	(lambda ()
	  (setq electric-indent-chars '(?\n))))

;;(setq python-shell-interpreter "ipython3")
;;(setq python-shell-interpreter-args "--simple-prompt")
(when (executable-find "ipython")
  (setq python-shell-interpreter "ipython")
  (setq python-shell-interpreter-args "--simple-prompt"))

(global-set-key (kbd "C-M-c") 'compile)

;; change default split-window direction
;; nil for vertical, 1 for horizontal
(setq split-width-threshold nil)

;; allow copying from emacs to outside applications
(setq x-select-enable-clipboard t)

;; always init with column numbers being displayed
(setq column-number-mode t)

;; always init with line numbers
(global-linum-mode 1)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(mode-line ((t (:background "#073642" :box (:line-width 1 :color "#839496") :weight bold)))))
