;; User interface
(setq inhibit-startup-message t)

;; Backup files
(setq backup-directory-alist '(("." . "~/.emacs-saves")))
(setq backup-by-copying t)
(setq delete-old-versions t
      kept-new-versions 6
      kept-old-versions 2
      version-control t)

;; Display line numbers when in a programming mode - might need to do more to make this work right
(add-hook 'prog-mode-hook 'display-line-numbers-mode)


(tooltip-mode -1)
;;(set-fringe-mode 10)
(menu-bar-mode -1)
;; Turn on the visible bell
(setq visible-bell t)


;; Maybe set a font with (set-face-attribute) later
(set-face-attribute :font "Source Code Pro")
;;-x eval-buffer to reload settings here


;; Initialize package sources
(require 'package)

;;Make sure that we point to the orgmode version to make sure we're getting the most recent one direct from org
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
			 ("org" . "https://orgmode.org/elpa/")
			 ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)
;; Check if there is a package archive, if not load it. 
(unless package-archive-contents
  (package-refresh-contents))

;; Install use-package if it is not installed
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)

;; Download and install any packages we have set
(setq use-package-always-ensure t)

(use-package all-the-icons)

(use-package doom-themes)

;; add a t option to the theme to make sure that it doesn't bug us about running Lisp code every time
(load-theme 'doom-gruvbox t)

;;Show the commands that we're using in a window. Use clm/toggle-command-log-buffer to turn on
(use-package command-log-mode)
(global-command-log-mode)

;;Starting out with Ivy, might want to try Helm in the future
(use-package ivy
  :bind ("C-s" . swiper))
(ivy-mode 1)

(use-package counsel)


(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1))


;; Maybe use a different theme to show the parens better
(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 2))

(use-package ivy-rich
  :init
  (ivy-rich-mode 1))

(use-package counsel
  :bind (("M-x" . counsel-M-x)
	 ("C-x b" . counsel-ibuffer)
	 ("C-x C-f" . counsel-find-file)
	 :map minibuffer-local-map
	 ("C-r" . 'counsel-minibuffer-history)))

;; May want to install 'helpful' later on

(defun efs/org-mode-setup ()
  (variable-pitch-mode 1)
  (visual-line-mode 1))

(load-file "~/.emacs.d/org-mode.el")
