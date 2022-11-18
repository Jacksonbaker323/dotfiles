;;;;
;; Packages
;;;;

;; Define package repositories
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives
	     '("elpa" . "https://elpa.gnu.org/packages/") t)
(add-to-list 'package-archives
	     '("org" . "https://orgmode.org/elpa") t)

;; Initialize package
(package-initialize)

;; Check to see if there are updates to packages
(unless package-archive-contents
  (package-refresh-contents))

;; Use-package preferences

 ;; Initialize use-package on non-Linux platforms
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

(use-package auto-package-update
	     :custom
	     (auto-package-update-interval 7)
	     (auto-package-update-prompt-before-update t)
	     (auto-package-update-hide-results t)
	     :config
	     (auto-package-update-maybe)
	     (auto-package-update-at-time "09:00"))


;;;;
;; UI
;;;;

(use-package doom-themes
  :init (load-theme 'doom-gruvbox t))

(setq inhibit-startup-message t)

(menu-bar-mode -1)

(use-package doom-modeline
  :init (doom-modeline-mode 1)
  :custom ((doom-modeline-height 15)))

(use-package all-the-icons
  :if (display-graphic-p))


;;;;
;; Convenience items
;;;;

;;No-littering package to keep auto-save files in the same place
(use-package no-littering)
(setq auto-save-file-name-transforms
      `((".*" ,(no-littering-expand-var-file-name "auto-save/") t)))


;;;;
;; Clojure
;;;;

;;;;;;;;
;;;; Cider
;;;;;;;;

(use-package cider
  :hook
  (eldoc-mode)

  :init
  ;; go right to the REPL buffer when it's finished connecting
  (setq cider-repl-pop-to-buffer-on-connect t)
  ;; When there's a cider error, show its buffer and switch to it
  (setq cider-show-error-buffer t)
  (setq cider-auto-select-error-buffer t)
  ;; Where to store the cider history.
  (setq cider-repl-history-file "~/.emacs.d/cider-history")
  ;; Wrap when navigating history.
  (setq cider-repl-wrap-history t)

  :config
  (defun cider-start-http-server ()
    (interactive)
    (cider-load-current-buffer)
    (let ((ns (cider-current-ns)))
      (cider-repl-set-ns ns)
      (cider-interactive-eval (format "(println '(def server (%s/start))) (println 'server)" ns))
      (cider-interactive-eval (format "(def server (%s/start)) (println server)" ns))))

  (defun cider-refresh ()
    (interactive)
    (cider-interactive-eval (format "(user/reset)")))

  (defun cider-user-ns ()
    (interactive)
    (cider-repl-set-ns "user"))

  :bind
  ("C-c u" . cider-user-ns))




(use-package paredit
  :hook
  (clojure-mode cider-repl-mode))




(use-package clojure-mode
  :init
  ;; Use clojure mode for other extensions
  (add-to-list 'auto-mode-alist '("\\.edn$" . clojure-mode))
  (add-to-list 'auto-mode-alist '("\\.boot$" . clojure-mode))
  (add-to-list 'auto-mode-alist '("\\.cljs.*$" . clojure-mode))
  (add-to-list 'auto-mode-alist '("lein-env" . enh-ruby-mode))
  :bind
  (("C-c C-v" . cider-start-http-server )
   ("C-M-r" . cider-refresh)
   ("C-c u" . cider-user-ns)
  ))

(use-package clojure-mode-extra-font-locking)

(use-package projectile
  :config (projectile-global-mode))

(use-package rainbow-delimiters)

(use-package tagedit)

(use-package magit)

(use-package ivy
  :diminish
  :bind (("C-s" . swiper)
         :map ivy-minibuffer-map
         ("TAB" . ivy-alt-done)
         ("C-l" . ivy-alt-done)
         ("C-j" . ivy-next-line)
         ("C-k" . ivy-previous-line)
         :map ivy-switch-buffer-map
         ("C-k" . ivy-previous-line)
         ("C-l" . ivy-done)
         ("C-d" . ivy-switch-buffer-kill)
         :map ivy-reverse-i-search-map
         ("C-k" . ivy-previous-line)
         ("C-d" . ivy-reverse-i-search-kill))
  :config
  (ivy-mode 1))

(use-package ivy-rich
  :after ivy
  :init
  (ivy-rich-mode 1))

(use-package counsel
  :bind (("C-M-j" . 'counsel-switch-buffer)
         :map minibuffer-local-map
         ("C-r" . 'counsel-minibuffer-history))
  :custom
  (counsel-linux-app-format-function #'counsel-linux-app-format-function-name-only)
  :config
  (counsel-mode 1))

(use-package ivy-prescient
  :after counsel
  :custom
  (ivy-prescient-enable-filtering nil)
  :config
  ;; Uncomment the following line to have sorting remembered across sessions!
  ;(prescient-persist-mode 1)
  (ivy-prescient-mode 1))

(use-package helpful
  :commands (helpful-callable helpful-variable helpful-command helpful-key)
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . counsel-describe-function)
  ([remap describe-command] . helpful-command)
  ([remap describe-variable] . counsel-describe-variable)
  ([remap describe-key] . helpful-key))


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(helpful ivy-prescient counsel ivy-rich ivy magit tagedit rainbow-delimiters paredit clojure-mode-extra-font-locking use-package no-littering doom-themes doom-modeline auto-package-update all-the-icons)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
