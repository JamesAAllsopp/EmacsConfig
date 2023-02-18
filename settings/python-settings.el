
;; Hide the modeline for inferior python processes
(use-package inferior-python-mode
         :ensure nil
         :hook (inferior-python-mode . hide-mode-line-mode))

;; Required to easily switch virtual envs
;; via the menu bar or with `pyvenv-workon`
;; Setting the `WORKON_HOME` environment variable points
;; at where the envs are located. I use miniconda.
(use-package pyvenv
         :ensure t
         :config
         ;; Setting work on to easily switch between environments
         (setenv "WORKON_HOME" (expand-file-name "~/.virtualenvs/"))
         ;; Display virtual envs in the menu bar
         (setq pyvenv-menu t
           venv-byhost
           '(("hawaiian" . "~/.virtualenvs/"))
           venv-location (cdr
                  (assoc system-name venv-byhost))
           default-venv-byhost
           '(("hawaiian" . "~/.virtualenvs/python3_10"))
           default-venv (cdr
                 (assoc system-name default-venv-byhost))
           python-environment-directory venv-location)
         ;; Restart the python process when switching environments
         (add-hook 'pyvenv-post-activate-hooks (lambda ()
                             (pyvenv-restart-python)))
         :hook (python-mode . pyvenv-mode))

;; Built-in Python utilities
(use-package python
         :after (pyvenv)
         :ensure t
         :config
         ;; Remove guess indent python message
         (setq python-indent-guess-indent-offset-verbose nil
           python-shell-interpreter "ipython"
           python-shell-interpreter-args "-i --simple-prompt"
           ;; python-environment-directory venv-location)
           python-environment-directory venv-location)
         ;; Use IPython when available or fall back to regular Python
         ;; (cond
         ;;  ((executable-find "ipython")
         ;;   (progn
         ;;     (setq python-shell-buffer-name "IPython")
         ;;     (setq python-shell-interpreter "ipython")
         ;;     (setq python-shell-interpreter-args "-i --simple-prompt")))
         ;;  ((executable-find "python3")
         ;;   (setq python-shell-interpreter "python3"))
         ;;  ((executable-find "python2")
         ;;   (setq python-shell-interpreter "python2"))
         ;;  (t
         ;;   (setq python-shell-interpreter "python")))
         :bind (:map python-mode-map
             ("C-c p t" . python-pytest-dispatch)
             ("C-c p l" . pylint)
             ("C-c p n" . numpydoc-generate)
             ("C-c p b" . blacken-buffer)
             ("C-c p v" . pyvenv-workon)))

;;; https://github.com/wbolster/emacs-python-pytest
(use-package python-pytest
         :after (pyvenv)
         :ensure t
         :defer 2)

;; https://github.com/pythonic-emacs/blacken
(use-package blacken
         :ensure t
         :defer 3
         :custom
         (blacken-line-length 120)
         :hook (python-mode . blacken-mode))

;; https://github.com/erickgnavar/flymake-ruff
(use-package flymake-ruff
         :ensure t
         :defer 3)

;; https://github.com/douglasdavis/numpydoc.el
(use-package numpydoc
         :ensure t
         :defer t
         :after lsp
         :custom
         (numpydoc-prompt-for-input t)
         (numpydoc-insert-examples-block nil)
         :bind (:map python-mode-map
             ("C-c p n" . numpydoc-generate)))

;; https://github.com/millejoh/emacs-ipython-notebook
(use-package ein
         :ensure t
         :defer t)
