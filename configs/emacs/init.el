(org-babel-load-file
 (expand-file-name
  "config.org"
  user-emacs-directory))
 
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-agenda-files nil)
 '(package-selected-packages
   '(counsel doom-themes dashboard dired eshell-syntax-highlighting evil-tutor evil-collection general magit-todos magit-lfs ox-man org-tempo sudo-edit smex which-key all-the-icons use-package toc-org projectile org-bullets vterm))
 '(persp-mode t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
