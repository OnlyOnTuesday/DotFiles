 
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
   '("melpa" . "http://melpa.milkbox.net/packages/")
   '("marmalade" . "http://marmalade-rep.org/packages/")))

;; enable  loading of files downloaded manually
(add-to-list
 'load-path "~/.emacs.d/user-download/")

(load "tetris")


;; add slime
(setq inferior-lisp-program "/usr/bin/sbcl")
(setq slime-contribs '(slime-fancy))

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
(require 'hexview-mode)

;;; CUSTOMIZE COLORS -------------------------------------------------

;; set the default colors for an emacs buffer/frame/whatever
;; (defvar bright-mode)
;; (setq bright-mode nil)
;; (add-variable-watcher bright-mode (if bright-mode
;;     (setq default-frame-alist
;; 	  '(
;; 	    (background-color . "white")
;; 	    (foreground-color . "black")))

(if (eq window-system "x")
    ;; use 'modify-all-frames-paremeters' instead of
    ;; 'setq default-frame-alist' to make interactive
    (modify-all-frames-parameters 
	  '(
	    (background-color . "gray20") ;; gray20, orchid1
	    (foreground-color . "orchid1")))
  (modify-all-frames-parameters
	'(
	  (background-color . "gray20")
	  (foreground-color . "brightgreen"))))


;;; MISCELLANEOUS COMMANDS -------------------------------------------

;; automatically indent python code
(add-hook 'python-mode-hook
	(lambda ()
	  (setq electric-indent-chars '(?\n))))

(setq python-shell-interpreter "ipython")
(setq python-shell-interpreter-args "--simple-prompt")

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

;;; CUSTOM -----------------------------------------------------------

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(menu-bar-mode nil)
 '(package-archives
   (quote
    (("marmalade" . "http://marmalade-repo.org/packages/")
     ("gnu" . "https://elpa.gnu.org/packages/")
     ("melpa" . "http://melpa.milkbox.net/packages/"))))
 '(package-selected-packages (quote (ipython ghc org 0blayout company slime)))
 '(scroll-bar-mode nil)
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(border ((t nil)))
 '(font-lock-comment-delimiter-face ((t (:inherit font-lock-comment-face :foreground "lightblue"))))
 '(font-lock-comment-face ((t (:foreground "lightblue"))))
 '(font-lock-string-face ((t (:foreground "color-207"))))
 '(internal-border ((t nil)))
 '(vertical-border ((((type tty)) nil))))
