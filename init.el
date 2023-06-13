(package-initialize)
(require 'package)

;; Adding repositories along with priority https://emacs.stackexchange.com/a/2989/10100
(setq package-archives
      '(("GNU ELPA" . "https://elpa.gnu.org/packages/")
        ("NonGNU ELPA"  . "https://elpa.nongnu.org/nongnu/")
        ("MELPA Stable" . "https://stable.melpa.org/packages/")
        ("MELPA"    . "https://melpa.org/packages/"))
      package-archive-priorities
      '(("MELPA" . 10)
        ("GNU ELPA" . 5)
        ("NonGNU ELPA"  . 5)
        ("MELPA Stable" . 0)))
;; On some systems we have problems communicating with ELPA (https://emacs.stackexchange.com/a/62210)
(setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")

(when (not package-archive-contents)
  (package-refresh-contents))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-agenda-files '("~/.org/home_jobs.org"))
 '(package-selected-packages
   '(centaur-tabs magit ein numpydoc flymake-ruff blacken python-pytest pyvenv modus-themes helpful which-key use-package spacegray-theme org-superstar org-roam-bibtex org-ref org-appear olivetti mixed-pitch helm-bibtex deft company-posframe)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-and-compile
  (setq use-package-always-ensure t
        use-package-expand-minimally t))

;; BASIC CUSTOMISATION
;; --------------------------------------
(use-package emacs
         :init
         (tool-bar-mode -1)
         (scroll-bar-mode -1)
         (menu-bar-mode 1)
         (global-linum-mode t)
         (global-hl-line-mode 1)
         (savehist-mode 1)
         (recentf-mode 1)
         (global-auto-revert-mode 1)
         :config
         ;; Add local lisp for miscellaneous things
         (add-to-list 'load-path "~/.config/emacs/lisp/") ; Local LISP
         (setq inhibit-startup-message t)    ; hide the startup message
         (setq global-visual-line-mode t)    ; Visual line wrap
         (setq inhibit-startup-screen t)     ; Disable startup screen
         (setq initial-scratch-message "")   ; Make *scratch* buffer blank
         (setq confirm-kill-processes nil)   ; Stop confirming the killing of processes
         (setq ring-bell-function 'ignore)   ; Disable bell sound
         (setq global-auto-revert-non-file-buffers t) ; Update non-file buffers (Dired) when disk changes
         (setq use-dialog-box nil)           ; No dialog pop-ups
         (setq history-length 100)           ; Mini-buffer history
         (setq-default fill-column 120)      ; Reset line-length
         (setq undo-limit 320000)            ; Increase the undo history limits
             (setq vc-follow-symlinks t)         ; open source of symlink maintain vc (https://stackoverflow.com/a/30900018/1444043)
         (setq undo-strong-limit 640000)
             (setq mode-line-compact t)
         (setq-default indent-tabs-mode nil)
         (setq-default tab-width 4)
         (setq-default sh-basic-offset 2)
         (setq-default sh-indentation 2)
         (setq-default cursor-type 'bar)     ; Line-style cursor similar to other text editors
         (setq-default frame-title-format '("%f"))     ; Make window title the buffer name
         :bind (("C-c U" . revert-buffer)
            ("C-c D" . toggle-debug-on-error)
            ;; Org
            ("\C-cl" . org-store-link)
            ("\C-cc" . org-capture)
            ("\C-ca" . org-agenda)
            ("\C-cb" . org-iswitchb)
            ("C-x p i" . org-org-cliplink) ;; From : https://github.com/rexim/org-cliplink
            ;; Magit /code review
            ("C-x g" . magit-status)
            ("C-c P" . magit-push-current-to-upstream)
            ("C-c F" . magit-pull)
            ("C-c R" . code-review-forge-pr-at-point))
         :hook
         ((latex-mode
           markdown-mode
           org-mode
           prog-mode
           text-mode) . auto-fill-mode)
         (auto-fill-function . do-auto-fill)
         (before-save . delete-trailing-whitespace) ;; https://emacs.stackexchange.com/a/40773/10100
         (prog-mode-hook . highlight-indent-guides-mode)
         )

;https://github.com/justbur/emacs-which-key
(use-package which-key
         :config (which-key-mode))

;; helpful settings
;; https://github.com/Wilfred/helpful
;;
(use-package helpful
         :config
         ;; Note that the built-in `describe-function' includes both functions
         ;; and macros. `helpful-function' is functions only, so we provide
         ;; `helpful-callable' as a drop-in replacement.
         (global-set-key (kbd "C-h f") #'helpful-callable)
         (global-set-key (kbd "C-h v") #'helpful-variable)
         (global-set-key (kbd "C-h k") #'helpful-key)
         ;; Lookup the current symbol at point. C-c C-d is a common keybinding
         ;; for this in lisp modes.
         (global-set-key (kbd "C-c C-d") #'helpful-at-point)

         ;; Look up *F*unctions (excludes macros).
         ;;
         ;; By default, C-h F is bound to `Info-goto-emacs-command-node'. Helpful
         ;; already links to the manual, if a function is referenced there.
         (global-set-key (kbd "C-h F") #'helpful-function)

         ;; Look up *C*ommands.
         ;;
         ;; By default, C-h C is bound to describe `describe-coding-system'. I
         ;; don't find this very useful, but it's frequently useful to only
         ;; look at interactive functions.
         (global-set-key (kbd "C-h C") #'helpful-command))

(use-package modus-themes
         :ensure t                         ; omit this to use the built-in themes
         :init
         ;; Add all your customizations prior to loading the themes
         (setq modus-themes-italic-constructs t
           modus-themes-bold-constructs t
           modus-themes-org-blocks '(tinted-background))
         :config
             :bind
             ("<f12>" . modus-themes-toggle))

(modus-themes-select 'modus-vivendi) ;; OR modus-operandi

(load "~/.emacs.d/settings/python-settings.el")
(load "~/.emacs.d/settings/font-settings.el")
(load "~/.emacs.d/settings/backups-settings.el")
(load "~/.emacs.d/settings/centaur-tabs.el")
(load "~/.emacs.d/settings/additional-org-mode.el")
(load "~/.emacs.d/settings/org-roam.el")
(load "~/.emacs.d/settings/mermaid-mode.el")
