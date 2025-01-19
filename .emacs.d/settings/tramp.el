(use-package tramp
  :ensure t
  :config
  (setq tramp-default-method "ssh")
  (add-to-list 'tramp-default-method-alist '("" "neil" "ssh"))
  ;; Set prompt so it doesn't hang
  (setq shell-prompt-pattern '"^[^#$%>\n]*~?[#$%>] *")
  ;; Set default usernames for different hosts and a global default.
  ;; (add-to-list 'tramp-default-user-alist
  ;;          '("ssh" ".*ovh'" "arch") t)
  ;; (add-to-list 'tramp-default-user-alist
  ;;          '("ssh" ".*openwrt" "admin") t)
  ;; (add-to-list 'tramp-default-user-alist
  ;;          '(nil nil "neil") t)
  ;; (add-to-list 'tramp-default-user-alist
  ;;          '("ssh" ".*alarmpi-4b" "neil") t)
  )

