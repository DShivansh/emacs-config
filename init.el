(winner-mode 1)
(setq visible-bell 1)
(set-face-attribute 'default nil :height 160)
(setq line-spacing 0.15)
(setq completion-styles '(flex basic))

(setq backup-directory-alist `((".*" . "~/.emacs.d/backups3/")))
(setq auto-save-file-name-transforms `((".*" "~/.emacs.d/backups3/" t)))

(ffap-bindings)
(setq eldoc-echo-area-use-multiline-p nil)
(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
             ("melpa" . "https://melpa.org/packages/")
             ("elpy" . "https://jorgenschaefer.github.io/packages/")))

(use-package almost-mono-themes
  :ensure t)

(use-package devil
  :ensure t
  :init (global-devil-mode)
  (setq devil-all-keys-repeatable t)
  :config (assoc-delete-all "%k SPC" devil-special-keys)
  :bind (("C-," . 'global-devil-mode)))


;; (use-package evil
;;   :init (evil-mode)
;;   :ensure t
;;   :config (define-key evil-insert-state-map (kbd "C-c") 'evil-force-normal-state)
;;   (evil-set-undo-system 'undo-redo)
;;   (define-key evil-normal-state-map (kbd "K") 'eldoc-print-current-symbol-info)
;;   (setq evil-default-state 'emacs))


(use-package vertico
  :ensure t
  :custom
  ;; (vertico-scroll-margin 0) ;; Different scroll margin
  (vertico-count 20) ;; Show more candidates
  ;; (vertico-resize t) ;; Grow and shrink the Vertico minibuffer
  (vertico-cycle t) ;; Enable cycling for `vertico-next/previous'
  :init
  (vertico-mode))

(use-package marginalia
  :ensure t
  :config
  (marginalia-mode 1))

(use-package consult
  :ensure t
  :bind (;; A recursive grep
         ("M-s M-g" . consult-grep)
         ;; Search for files names recursively
         ("M-s M-f" . consult-find)
         ;; Search through the outline (headings) of the file
         ("M-s M-o" . consult-outline)
         ;; Search the current buffer
         ("M-s M-l" . consult-line)
         ;; Switch to another buffer, or bookmarked file, or recently
         ;; opened file.
         ("M-s M-b" . consult-buffer)))

(savehist-mode 1)
(recentf-mode 1)

;; whitespace mode
(defun rc/set-up-whitespace-handling ()
  (interactive)
  (whitespace-mode 1)
  (setq whitespace-line-column 500)
  (add-to-list 'write-file-functions 'delete-trailing-whitespace))

;; clojure-mode
(use-package cider
  :ensure t)

(use-package paredit
  :ensure t)

(use-package expand-region
  :ensure t
  :bind ("C-=" . er/expand-region))

(use-package go-mode
  :ensure t)


;; git stuff
(use-package magit
  :ensure t
  :bind (("C-x g" . magit-status)
         ("C-x C-g" . magit-status)))

;; company mode and autocomplete

(use-package python
  :config
  ;; Remove guess indent python message
  (setq python-indent-guess-indent-offset-verbose nil))

(use-package company
  :ensure t
  :defer t
  :custom
  ;; Search other buffers with the same modes for completion instead of
  ;; searching all other buffers.
  (company-dabbrev-other-buffers t)
  (company-dabbrev-code-other-buffers t)
  ;; M-<num> to select an option according to its number.
  (company-show-numbers t)
  ;; Only 2 letters required for completion to activate.
  (company-minimum-prefix-length 3)
  ;; Do not downcase completions by default.
  (company-dabbrev-downcase nil)
  ;; Even if I write something with the wrong case,
  ;; provide the correct casing.
  (company-dabbrev-ignore-case t)
  ;; company completion wait
  (company-idle-delay 0.2)
  ;; No company-mode in shell & eshell
  (company-global-modes '(not eshell-mode shell-mode))
  ;; Use company with text and programming modes.
    :hook ((text-mode . company-mode)
           (prog-mode . company-mode)))

;; (use-package eglot
;;   :ensure t
;;   :defer t
;;   :hook (python-mode . eglot-ensure)
;;   ;; (java-mode . eglot-ensure)
;;   :config
;;   (add-to-list 'eglot-server-programs '(python-mode . ("pyright-langserver" "--stdio")) ;; '(java-mode . ("java" "-Declipse.application=org.eclipse.jdt.ls.core.id1"
;;                                                                                         ;;                "-Dosgi.bundles.defaultStartLevel=4"
;;                                                                                         ;;                "-Declipse.product=org.eclipse.jdt.ls.core.product"
;;                                                                                         ;;                "-Dlog.level=ALL"
;;                                                                                         ;;                "-Xmx1G"
;;                                                                                         ;;                "--add-modules=ALL-SYSTEM"
;;                                                                                         ;;                "--add-opens java.base/java.util=ALL-UNNAMED"
;;                                                                                         ;;                "--add-opens java.base/java.lang=ALL-UNNAMED"
;;                                                                                         ;;                "-jar ~/Documents/java/jdt-language-server-1.9.0-202203031534/plugins/./org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar"
;;                                                                                         ;;                "-configuration ~/Documents/java/jdt-language-server-1.9.0-202203031534/config_mac"
;;                                                                                         ;;                "-data ~/Documents/jdtls-workspace"
;;                                                                                         ;;                )
;;                                                                                         ;;             )
;;                )
;;   )

;;;; this is required to use the same $PATH as set in the terminal

(use-package exec-path-from-shell
  :ensure t
  :init (when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize)))

(use-package plain-theme
  :ensure t)

;; Returns the parent directory containing a .project.el file, if any,
;; to override the standard project.el detection logic when needed.
(defun zkj-project-override (dir)
  (let ((override (locate-dominating-file dir ".project.el")))
    (if override
      (cons 'vc override)
      nil)))

(use-package project
  ;; Cannot use :hook because 'project-find-functions does not end in -hook
  ;; Cannot use :init (must use :config) because otherwise
  ;; project-find-functions is not yet initialized.
  :config
  (add-hook 'project-find-functions #'zkj-project-override))


;; (use-package projectile
;;   :ensure t)
;; (use-package flycheck)
;; (use-package yasnippet :config (yas-global-mode))
;; (use-package lsp-mode :hook ((lsp-mode . lsp-enable-which-key-integration)))
;; (use-package hydra)
;; (use-package company)
;; (use-package lsp-ui)
;; (use-package which-key :config (which-key-mode))
;; (use-package lsp-java :config (add-hook 'java-mode-hook 'lsp))
;; (use-package dap-mode :after lsp-mode :config (dap-auto-configure-mode))
;; (use-package dap-java :ensure nil)
;; (use-package helm-lsp)
;; (use-package helm
;;   :config (helm-mode))

(use-package treemacs
  :ensure t
  :config (progn (setq treemacs-position 'right))
  :bind (("M-0" . treemacs)))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-show-quick-access t nil nil "Customized with use-package company")
 '(custom-enabled-themes '(tsdh-light))
 '(custom-safe-themes
   '("cbd85ab34afb47003fa7f814a462c24affb1de81ebf172b78cb4e65186ba59d2" "69d9245ceb3cb2e9b01e2367cff3c78abd30ebbc4387c0c45ac47e334a594ce1" "46e9b34ca8971629e5ad94694d7a3894b587d8a8fd7c6703fa2fd51d4317ac91" "377b4637d47e2772e89205de5fdd2a79e21db4a9eca339f16ddbe3e4d9fc2868" default))
 '(display-line-numbers 'relative)
 '(eglot-ignored-server-capabilities nil)
 '(indent-tabs-mode nil)
 '(package-selected-packages
   '(paredit almost-mono-themes plain-theme exec-path-from-shell consult marginalia vertico devil yasnippet which-key rainbow-delimiters magit lsp-java lsp-ivy kotlin-mode ivy-rich highlight-indent-guides helpful gruber-darker-theme go-mode expand-region evil-collection doom-themes counsel-projectile company cider))
 '(tool-bar-mode nil))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
