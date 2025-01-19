(use-package lsp-mode
  :ensure t
  :defer 1
  :init
  ;(setq lsp-keymap-prefix "s-l")
  :config
  (setq lsp-idle-delay 0.5
	lsp-enable-symbol-highlighting t
    ;lsp-pylsp-plugins-pylint-args ["--rcfile=/home/neil/dotfiles/python/.pylintrc"]
    )
  lsp-warn-no-matched-clients nil
  :hook ((lsp-mode . lsp-enable-which-key-integration)
	 (R-mode . lsp)
	 (bash-mode . lsp)
	 (dockerfile-mode . lsp)
	 ;; (ess-r-mode . lsp)
	 (gfm-mode . lsp)
	 (groovy-mode . lsp)
	 (html-mode . lsp)
	 (julia-mode . lsp)
	 (js-ts-mode . lsp)
	 (latex-mode . lsp)
	 (markdown-mode . lsp)
	 (org-mode . lsp)
	 (python-mode . lsp)
	 (rust-mode . lsp)
	 (sh-mode . lsp)
	 (terraform-mode . lsp)
	 (typescript-mode . lsp)))
