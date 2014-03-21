;;;;;; Emacs is not a package manager, and here we load its package manager!
(require 'package)
(dolist (source '(("marmalade" . "http://marmalade-repo.org/packages/")
                  ("elpa" . "http://tromey.com/elpa/")
                  ;; TODO: Maybe, use this after emacs24 is released
                  ;; (development versions of packages)
                  ("melpa" . "http://melpa.milkbox.net/packages/")
                  ))
  (add-to-list 'package-archives source t))
(package-initialize)


;;;;;;;;; yasnippet
;;; should be loaded before auto complete so that they can work together
(require 'yasnippet)
(yas-global-mode 1)


;;;;;;;;;used auto complete
;;; auto complete mod
;;; should be loaded after yasnippet so that they can work together
;;(require 'auto-complete-config)
;;(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
;;(ac-config-default)
;;; set the trigger key so that it can work together with yasnippet on tab key,
;;; if the word exists in yasnippet, pressing tab will cause yasnippet to
;;; activate, otherwise, auto-complete will
;;(ac-set-trigger-key "TAB")
;;(ac-set-trigger-key "<tab>")


;;;;;;;;;auto complete and clan to make it better
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")

(require 'auto-complete-clang)
(setq ac-auto-start nil)
(setq ac-quick-help-delay 0.5)
(ac-set-trigger-key "TAB")
;; (define-key ac-mode-map  [(control tab)] 'auto-complete)
(define-key ac-mode-map  [(control tab)] 'auto-complete)
(defun my-ac-config ()
  (setq-default ac-sources '(ac-source-abbrev ac-source-dictionary ac-source-words-in-same-mode-buffers))
  (add-hook 'emacs-lisp-mode-hook 'ac-emacs-lisp-mode-setup)
  ;; (add-hook 'c-mode-common-hook 'ac-cc-mode-setup)
  (add-hook 'ruby-mode-hook 'ac-ruby-mode-setup)
  (add-hook 'css-mode-hook 'ac-css-mode-setup)
  (add-hook 'auto-complete-mode-hook 'ac-common-setup)
  (global-auto-complete-mode t))
(defun my-ac-cc-mode-setup ()
  (setq ac-sources (append '(ac-source-clang ac-source-yasnippet) ac-sources)))
(add-hook 'c-mode-common-hook 'my-ac-cc-mode-setup)
;; ac-source-gtags
(my-ac-config)


;;;;;;;;; activate ecb
;;(require 'ecb)
;;(require 'ecb-autoloads)
;;(setq ecb-layout-name "leftright2")
;;(setq ecb-show-sources-in-directories-buffer 'always)


;;;;;;;;; flymake to check error by makefile
(require 'flymake)
(add-hook 'find-file-hook 'flymake-find-file-hook)


;;最大化
(defun my-maximized ()
  (interactive)
  (x-send-client-message
   nil 0 nil "_NET_WM_STATE" 32
   '(2 "_NET_WM_STATE_MAXIMIZED_HORZ" 0))
  (x-send-client-message
   nil 0 nil "_NET_WM_STATE" 32
   '(2 "_NET_WM_STATE_MAXIMIZED_VERT" 0))
)

;;(my-maximized)
;;(global-set-key (kbd "<f11>") 'my-maximized)

;;full screen
 (defun fullscreen ()
     (interactive)
      (set-frame-parameter nil 'fullscreen
                         (if (frame-parameter nil 'fullscreen) nil 'fullboth)))
(fullscreen)
(global-set-key (kbd "<f12>") 'fullscreen)


;;ignore toolbar
(tool-bar-mode -1)


;; speedbar设置
(load "sr-speedbar" 'noerror)
;; (setq speedbar-show-unknown-files t)
 (setq speedbar-use-images nil)
 (setq sr-speedbar-width 30)
(setq sr-speedbar-right-side nil)
(setq sr-speedbar-left-side 30)

(defun toggle-sr-speedbar () (lambda()
                               (interactive)
                               (sr-speedbar-toggle)
			       (sr-speedbar-refresh-turn-off)))

(global-set-key (kbd "<f8>") (toggle-sr-speedbar))
(sr-speedbar-open)

;;toggle horizen and vertical windows
(load "toggle-window")
(global-set-key [(control c) (|)] 'toggle-window-split) 

;;f9使用find-tag跳转
;;(global-set-key (kbd "<f9>") 'find-tag)


;;;;;;;f9 to compile
;; (defun my-compile ()
;;	(split-window-horizontally)
;;	(compile))
(global-set-key (kbd "<f9>") 'compile)

