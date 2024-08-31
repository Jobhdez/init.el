(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
;; and `package-pinned-packages`. Most users will not need or want to do this.
;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(use-package haskell-mode
  :ensure t)

(use-package typescript-mode
  :ensure t)

(use-package company
  :ensure t
  :after lsp-mode
  :hook (lsp-mode . company-mode))

(defun my/install-treesit-grammars ()
  (unless (treesit-language-available-p 'typescript)
    (treesit-install-language-grammar 'typescript))
  (unless (treesit-language-available-p 'tsx)
    (treesit-install-language-grammar 'tsx)))

;;(my/install-treesit-grammars)

(add-hook 'after-init-hook 'global-company-mode)
(load-theme 'manoj-dark t)
(global-display-line-numbers-mode)

;; Optional: Hook to run prettier on save (if you use Prettier)


(use-package eglot
  :ensure t)
(add-hook 'typescript-ts-mode-hook 'eglot-ensure)
(use-package web-mode
  :ensure t
  :mode ("\\.js\\'" "\\.jsx\\'" "\\.ts\\'" "\\.tsx\\'")
  :config
  ;; Configure indentation for JSX/TSX
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-code-indent-offset 2)
  (setq web-mode-css-indent-offset 2))


;; note: for prettier, you need prettier installed. install it with npm
;; and then in your ui directory you need a `.prettierrc` file with this
;; with parser: typescript
(use-package prettier
  :ensure t)
(add-hook 'after-init-hook #'global-prettier-mode)

(use-package lsp-mode
  :ensure t
  :after company lsp-ui)

(use-package lsp-ui
  :ensure t)

(use-package lsp-haskell
  :ensure t)

(add-hook 'haskell-mode-hook #'lsp)
(add-hook 'haskell-literate-mode-hook #'lsp)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(company web-mode typescript-mode prettier lsp-ui lsp-haskell)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
