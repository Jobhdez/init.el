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
  :ensure t)

(defun my/install-treesit-grammars ()
  (unless (treesit-language-available-p 'typescript)
    (treesit-install-language-grammar 'typescript))
  (unless (treesit-language-available-p 'tsx)
    (treesit-install-language-grammar 'tsx)))

;;(my/install-treesit-grammars)

(add-hook 'after-init-hook 'global-company-mode)

(load-theme 'manoj-dark t)
(global-display-line-numbers-mode)

(use-package prettier-js
   :ensure t)

(add-hook 'typescript-ts-mode-hook
          (lambda ()
            (prettier-js-mode)
            (add-hook 'before-save-hook 'prettier-js nil 'local)))

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
