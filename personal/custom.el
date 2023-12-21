(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#3F3F3F" "#CC9393" "#7F9F7F" "#F0DFAF" "#8CD0D3" "#DC8CC3" "#93E0E3" "#DCDCCC"])
 '(company-quickhelp-color-background "#4F4F4F")
 '(company-quickhelp-color-foreground "#DCDCCC")
 '(custom-enabled-themes '(manoj-dark))
 '(custom-safe-themes
   '("2540689fd0bc5d74c4682764ff6c94057ba8061a98be5dd21116bf7bf301acfb" default))
 '(fci-rule-color "#383838")
 '(ispell-dictionary nil)
 '(nrepl-message-colors
   '("#CC9393" "#DFAF8F" "#F0DFAF" "#7F9F7F" "#BFEBBF" "#93E0E3" "#94BFF3" "#DC8CC3"))
 '(package-selected-packages
   '(nix-mode reformatter org-roam treemacs-magit treemacs-icons-dired treemacs-projectile treemacs gradle-mode json-mode dockerfile-mode scala-mode afternoon-theme csv-mode smart-tabs-mode lsp-treemacs lsp-python-ms yasnippet-lean yaml-mode use-package lsp-ui yasnippet company-lsp lsp-mode cmake-mode exec-path-from-shell zop-to-char zenburn-theme which-key volatile-highlights undo-tree super-save smartrep smartparens operate-on-number move-text magit projectile imenu-anywhere hl-todo guru-mode gitignore-mode gitconfig-mode git-timemachine gist flycheck expand-region epl editorconfig easy-kill diminish diff-hl discover-my-major crux browse-kill-ring beacon anzu ace-window cmake-mode groovy-mode))
 '(pdf-view-midnight-colors '("#DCDCCC" . "#383838"))
 '(prelude-whitespace nil)
 '(vc-annotate-background "#2B2B2B")
 '(vc-annotate-color-map
   '((20 . "#BC8383")
     (40 . "#CC9393")
     (60 . "#DFAF8F")
     (80 . "#D0BF8F")
     (100 . "#E0CF9F")
     (120 . "#F0DFAF")
     (140 . "#5F7F5F")
     (160 . "#7F9F7F")
     (180 . "#8FB28F")
     (200 . "#9FC59F")
     (220 . "#AFD8AF")
     (240 . "#BFEBBF")
     (260 . "#93E0E3")
     (280 . "#6CA0A3")
     (300 . "#7CB8BB")
     (320 . "#8CD0D3")
     (340 . "#94BFF3")
     (360 . "#DC8CC3")))
 '(vc-annotate-very-old-color "#DC8CC3"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(lsp-face-highlight-read ((t (:inherit highlight :background "black" :foreground "white" :box nil :underline t))))
 '(region ((t (:background "blue" :foreground "white")))))

;; Required for Emacs < 29.x, otherwise treemacs breaks with something about invalid image type svg
(unless (and (not (eq (boundp 'image-types) nil)) (member 'svg image-types)
             (add-to-list 'image-types 'svg)))

;; Make it easier to change the size of a frame.
;; See https://www.emacswiki.org/emacs/WindowResize
(global-set-key (kbd "S-C-<left>") 'shrink-window-horizontally)
(global-set-key (kbd "S-C-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "S-C-<down>") 'shrink-window)
(global-set-key (kbd "S-C-<up>") 'enlarge-window)

;; (add-to-list 'default-frame-alist '(font . "jetbrains-mono"))
;; (set-face-attribute 'default t :font "jetbrains-mono")

(set-variable 'projectile-globally-ignored-directories '(".idea" ".ensime_cache" ".eunit" ".git" ".hg" ".fslckout" "_FOSSIL_" ".bzr" "_darcs" ".tox" ".svn" ".stack-work" ".clangd"))

;; C++ dev setup
(c-set-offset 'innamespace 0)

(setq c-default-style "linux"
      c-basic-offset 4
      tab-width 4
      indent-tabs-mode t)

(eval-after-load 'company
  '(add-to-list 'company-backends 'company-lsp))

;; Emacs 29 and later seem to have use-package with :bind built in. For earlier
;; releases install it this way.
(unless (package-installed-p 'use-package)
  (progn
    (package-install 'use-package)
    (unless (package-installed-p 'bind-key)
      (package-install 'bind-key))))

;; TODO: Use flymake-show-diagnostics-buffer
;; TODO: set up lsp-ivy for find symbol by name
(use-package lsp-mode
  :init
  (setq lsp-keymap-prefix "C-c l")
  :hook (c++-mode . lsp)
  :hook (c-mode . lsp)
  :hook (python-mode . lsp)
  :hook (java-mode . lsp)
  :bind (("C-q" . lsp-ui-peek-find-definitions)
         ("M-\\" . lsp-find-references)
         ("M-." . lsp-find-definition))
  :commands lsp
  :config
  (setq lsp-clients-clangd-args '("-j=12" "-background-index" "-log=error")))

(use-package lsp-ui
  :bind (("M-G" . lsp-ui-find-workspace-symbol)
         ("C-S-f" . projectile-find))
  :commands lsp-ui-mode)
(use-package company-lsp :commands company-lsp)

(company-mode t)
(ido-mode t)
(show-paren-mode t)
(setq global-hl-line-mode nil)

(if (not (eq nil (boundp 'scroll-bar-mode)))
    (scroll-bar-mode -1))

(use-package treemacs
  :ensure t
  :defer t
  :init
  (with-eval-after-load 'winum
    (define-key winum-keymap (kbd "M-0") #'treemacs-select-window))
  :config
  (progn
    (setq treemacs-collapse-dirs                   (if treemacs-python-executable 3 0)
          treemacs-deferred-git-apply-delay        0.5
          treemacs-directory-name-transformer      #'identity
          treemacs-display-in-side-window          t
          treemacs-eldoc-display                   'simple
          treemacs-file-event-delay                2000
          treemacs-file-extension-regex            treemacs-last-period-regex-value
          treemacs-file-follow-delay               0.2
          treemacs-file-name-transformer           #'identity
          treemacs-follow-after-init               t
          treemacs-expand-after-init               t
          treemacs-find-workspace-method           'find-for-file-or-pick-first
          treemacs-git-command-pipe                ""
          treemacs-goto-tag-strategy               'refetch-index
          treemacs-header-scroll-indicators        '(nil . "^^^^^^")
          treemacs-hide-dot-git-directory          t
          treemacs-indentation                     2
          treemacs-indentation-string              " "
          treemacs-is-never-other-window           nil
          treemacs-max-git-entries                 5000
          treemacs-missing-project-action          'ask
          treemacs-move-forward-on-expand          nil
          treemacs-no-png-images                   nil
          treemacs-no-delete-other-windows         t
          treemacs-project-follow-cleanup          nil
          treemacs-persist-file                    (expand-file-name ".cache/treemacs-persist" user-emacs-directory)
          treemacs-position                        'left
          treemacs-read-string-input               'from-child-frame
          treemacs-recenter-distance               0.1
          treemacs-recenter-after-file-follow      nil
          treemacs-recenter-after-tag-follow       nil
          treemacs-recenter-after-project-jump     'always
          treemacs-recenter-after-project-expand   'on-distance
          treemacs-litter-directories              '("/node_modules" "/.venv" "/.cask")
          treemacs-project-follow-into-home        nil
          treemacs-show-cursor                     nil
          treemacs-show-hidden-files               t
          treemacs-silent-filewatch                nil
          treemacs-silent-refresh                  nil
          treemacs-sorting                         'alphabetic-asc
          treemacs-select-when-already-in-treemacs 'move-back
          treemacs-space-between-root-nodes        t
          treemacs-tag-follow-cleanup              t
          treemacs-tag-follow-delay                1.5
          treemacs-text-scale                      nil
          treemacs-user-mode-line-format           nil
          treemacs-user-header-line-format         nil
          treemacs-wide-toggle-width               70
          treemacs-width                           35
          treemacs-width-increment                 1
          treemacs-width-is-initially-locked       t
          treemacs-workspace-switch-cleanup        nil)

    ;; The default width and height of the icons is 22 pixels. If you are
    ;; using a Hi-DPI display, uncomment this to double the icon size.
    ;;(treemacs-resize-icons 44)

    (treemacs-follow-mode t)
    (treemacs-filewatch-mode t)
    (treemacs-fringe-indicator-mode 'always)
    (when treemacs-python-executable
      (treemacs-git-commit-diff-mode t))

    (pcase (cons (not (null (executable-find "git")))
                 (not (null treemacs-python-executable)))
      (`(t . t)
       (treemacs-git-mode 'deferred))
      (`(t . _)
       (treemacs-git-mode 'simple)))

    (treemacs-hide-gitignored-files-mode nil))
  :bind
  (:map global-map
        ("M-0"       . treemacs-select-window)
        ("C-x t 1"   . treemacs-delete-other-windows)
        ("C-x t t"   . treemacs)
        ("C-x t d"   . treemacs-select-directory)
        ("C-x t B"   . treemacs-bookmark)
        ("C-x t C-t" . treemacs-find-file)
        ("C-x t M-t" . treemacs-find-tag)))

(use-package lsp-treemacs
  :after lsp)

(use-package lsp-ivy
  :after lsp)

;; FIXME: Find path for lldb-vscode-11 or lldb-vscode
;; (use-package dap-mode
;;   :defer
;;   :custom
;;   (dap-auto-configure-mode t "Automatically configure dap.")
;;   :config
;;   (require 'dap-lldb)
;;   (require 'dap-cpptools)
;;   (setq dap-lldb-debug-program '("lldb-vscode-11"))
;;   (setq dap-lldb-debugged-program-function (lambda () (read-file-name "What To Debug?")))
;;   (dap-register-debug-template  
;;    "C++ LLDB"                   
;;    (list :type "lldb-vscode"   
;;          :cwd nil
;;          :args nil
;;          :request "launch"
;;          :program nil))
;;   :after lsp-mode)
;; (require 'dap-lldb)

(use-package treemacs-projectile
  :after (treemacs projectile)
  :ensure t)

(use-package treemacs-icons-dired
  :hook (dired-mode . treemacs-icons-dired-enable-once)
  :ensure t)

(use-package treemacs-magit
  :after (treemacs magit)
  :ensure t)

(whitespace-mode nil)

;; Special config for Linux kernel source trees
(defun c-lineup-arglist-tabs-only (ignored)
  "Line up argument lists by tabs, not spaces"
  (let* ((anchor (c-langelem-pos c-syntactic-element))
         (column (c-langelem-2nd-pos c-syntactic-element))
         (offset (- (1+ column) anchor))
         (steps (floor offset c-basic-offset)))
    (* (max steps 1)
       c-basic-offset)))

(dir-locals-set-class-variables
 'linux-kernel
 '((c-mode . (
              (c-basic-offset . 8)
              (c-label-minimum-indentation . 0)
              (c-offsets-alist . (
                                  (arglist-close         . c-lineup-arglist-tabs-only)
                                  (arglist-cont-nonempty .
                                                         (c-lineup-gcc-asm-reg c-lineup-arglist-tabs-only))
                                  (arglist-intro         . +)
                                  (brace-list-intro      . +)
                                  (c                     . c-lineup-C-comments)
                                  (case-label            . 0)
                                  (comment-intro         . c-lineup-comment)
                                  (cpp-define-intro      . +)
                                  (cpp-macro             . -1000)
                                  (cpp-macro-cont        . +)
                                  (defun-block-intro     . +)
                                  (else-clause           . 0)
                                  (func-decl-cont        . +)
                                  (inclass               . +)
                                  (inher-cont            . c-lineup-multi-inher)
                                  (knr-argdecl-intro     . 0)
                                  (label                 . -1000)
                                  (statement             . 0)
                                  (statement-block-intro . +)
                                  (statement-case-intro  . +)
                                  (statement-cont        . +)
                                  (substatement          . +)
                                  ))
              (indent-tabs-mode . t)
              (show-trailing-whitespace . t)
              ))))

(dir-locals-set-directory-class
 (expand-file-name "~/code/linux")
 'linux-kernel)

;; TODO stuff for Northguard. Mainly I want to disable whitespace-mode
;; (dir-locals-set-directory-class
;;  (expand-file-name "~/code/cpp/Northguard")
;;  'northguard)

(use-package org-roam
  :ensure t
  :init
  (setq org-roam-v2-ack t)
  (visual-line-mode t)
  (org-indent-mode t)
  :custom
  (org-roam-directory "~/Notes")
  (org-roam-completion-everywhere t)
  :bind (("C-c n l" . org-roam-buffer-toggle)
         ("C-c n f" . org-roam-node-find)
         ("C-c n i" . org-roam-node-insert)
         :map org-mode-map
         ("C-M-i" . completion-at-point))
  :config (org-roam-setup))

;; Disable line numbers for some modes
(dolist (mode '(org-mode-hook
                term-mode-hook
                shell-mode-hook
                treemacs-mode-hook
                eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

;; (use-package org-bullets
;;   :hook (org-mode . org-bullets-mode))
(use-package org-bullets
  :ensure t)
;; also use visual-line-mode
;; also use org-indent-mode


(add-hook 'org-mode (lambda () (org-indent-mode t)))

;; TODO: When editing .org or .md files, disable whitespace-mode, enable visual-line-mode
;; TODO: Tell whitespace-mode to enforce line length depending on which project I'm working on. 120 for work. 80 for Haiku, etc.

;; TODO: Only enable these if nix is available
(use-package reformatter
  :ensure t)

(use-package lsp-nix
  :ensure lsp-mode
  :after (lsp-mode)
  :demand t
  :custom
  (lsp-nix-nil-formatter ["nixpkgs-fmt"]))

;(use-package nix-mode
;  :hook (nix-mode . lsp-deferred)

;; (use-package nix-mode
;;   :hook (nix-mode . lsp-deferred)
;;   :ensure t)

(use-package flatbuffers-mode
  :ensure t)

(use-package lsp-java
  :ensure t)
