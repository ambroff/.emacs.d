(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#3F3F3F" "#CC9393" "#7F9F7F" "#F0DFAF" "#8CD0D3" "#DC8CC3" "#93E0E3"
    "#DCDCCC"])
 '(auth-source-save-behavior nil)
 '(company-quickhelp-color-background "#4F4F4F")
 '(company-quickhelp-color-foreground "#DCDCCC")
 '(custom-enabled-themes '(manoj-dark))
 '(custom-safe-themes
   '("2540689fd0bc5d74c4682764ff6c94057ba8061a98be5dd21116bf7bf301acfb"
     default))
 '(fci-rule-color "#383838")
 '(ispell-dictionary nil)
 '(lsp-completion-enable-additional-text-edit nil)
 '(mu4e-split-view 'vertical)
 '(nrepl-message-colors
   '("#CC9393" "#DFAF8F" "#F0DFAF" "#7F9F7F" "#BFEBBF" "#93E0E3"
     "#94BFF3" "#DC8CC3"))
 '(org-babel-load-languages
   '((emacs-lisp . t) (awk . t) (shell . t) (python . t) (scheme . t)))
 '(package-selected-packages
   '(ac-etags ace-window afternoon-theme anzu bazel beacon
              browse-kill-ring claude-code-ide cmake-mode cmake-mode
              company-lsp crux csv-mode debbugs diff-hl diminish
              discover-my-major dockerfile-mode easy-kill eat
              editorconfig embark embark-consult epl
              exec-path-from-shell expand-region flatbuffers-mode
              flycheck geiser-guile gist git-timemachine
              gitconfig-mode gitignore-mode gradle-mode groovy-mode
              guru-mode hl-todo imenu-anywhere json-mode json-rpc
              jsonrpc lsp-java lsp-mode lsp-python-ms lsp-sonarlint
              lsp-treemacs lsp-ui magit marginalia meson-mode
              move-text ninja-mode nix-mode operate-on-number
              org-bullets org-roam projectile protobuf-mode
              reformatter rust-mode scala-mode smart-tabs-mode
              smartparens smartrep super-save treemacs
              treemacs-icons-dired treemacs-magit treemacs-projectile
              undo-tree use-package volatile-highlights vterm
              which-key yaml-mode yasnippet yasnippet-lean
              zenburn-theme zop-to-char))
 '(package-vc-selected-packages
   '((claude-code-ide :url
                      "https://github.com/manzaltu/claude-code-ide.el")))
 '(pdf-view-midnight-colors '("#DCDCCC" . "#383838"))
 '(prelude-whitespace nil)
 '(projectile-use-git-grep t)
 '(safe-local-variable-values
   '((eval progn (require 'lisp-mode)
           (defun emacs27-lisp-fill-paragraph (&optional justify)
             (interactive "P")
             (or (fill-comment-paragraph justify)
                 (let
                     ((paragraph-start
                       (concat paragraph-start
                               "\\|\\s-*\\([(;\"]\\|\\s-:\\|`(\\|#'(\\)"))
                      (paragraph-separate
                       (concat paragraph-separate
                               "\\|\\s-*\".*[,\\.]$"))
                      (fill-column
                       (if
                           (and
                            (integerp emacs-lisp-docstring-fill-column)
                            (derived-mode-p 'emacs-lisp-mode))
                           emacs-lisp-docstring-fill-column
                         fill-column)))
                   (fill-paragraph justify))
                 t))
           (setq-local fill-paragraph-function
                       #'emacs27-lisp-fill-paragraph))
     (eval modify-syntax-entry 43 "'")
     (eval modify-syntax-entry 36 "'")
     (eval modify-syntax-entry 126 "'")
     (geiser-repl-per-project-p . t)
     (eval with-eval-after-load 'yasnippet
           (let
               ((guix-yasnippets
                 (expand-file-name "etc/snippets/yas"
                                   (locate-dominating-file
                                    default-directory ".dir-locals.el"))))
             (unless (member guix-yasnippets yas-snippet-dirs)
               (add-to-list 'yas-snippet-dirs guix-yasnippets)
               (yas-reload-all))))
     (eval setq-local guix-directory
           (locate-dominating-file default-directory ".dir-locals.el"))
     (eval add-to-list 'completion-ignored-extensions ".go")))
 '(vc-annotate-background "#2B2B2B")
 '(vc-annotate-color-map
   '((20 . "#BC8383") (40 . "#CC9393") (60 . "#DFAF8F") (80 . "#D0BF8F")
     (100 . "#E0CF9F") (120 . "#F0DFAF") (140 . "#5F7F5F")
     (160 . "#7F9F7F") (180 . "#8FB28F") (200 . "#9FC59F")
     (220 . "#AFD8AF") (240 . "#BFEBBF") (260 . "#93E0E3")
     (280 . "#6CA0A3") (300 . "#7CB8BB") (320 . "#8CD0D3")
     (340 . "#94BFF3") (360 . "#DC8CC3")))
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

;; On Haiku and Haven, I change the default keymap so command is super alt is alt.
(if (or (eq system-type 'haiku) (eq system-type 'haven))
    (progn (setq haiku-meta-keysym 'option)
           (setq haiku-super-keysym 'command)))


(if (not (or (eq system-type 'haiku) (eq system-type 'haven)))
    (progn
      ;;
      ;; Use different fonts
      ;;
      ;; You will most likely need to adjust this font size for your system!
      (defvar efs/default-font-size 120)
      (defvar efs/default-variable-font-size 120)

      ;; Make frame transparency overridable
      (defvar efs/frame-transparency '(90 . 90))

      (set-face-attribute 'default nil :font "Fira Code Retina" :height efs/default-font-size)

      ;; Set the fixed pitch face
      (set-face-attribute 'fixed-pitch nil :font "Fira Code Retina" :height efs/default-font-size)

      ;; Set the variable pitch face
      (set-face-attribute 'variable-pitch nil :font "Cantarell" :height efs/default-variable-font-size :weight 'regular)

      ;; Make it easier to change the size of a frame.
      ;; See https://www.emacswiki.org/emacs/WindowResize
      (global-set-key (kbd "S-C-<left>") 'shrink-window-horizontally)
      (global-set-key (kbd "S-C-<right>") 'enlarge-window-horizontally)
      (global-set-key (kbd "S-C-<down>") 'shrink-window)
      (global-set-key (kbd "S-C-<up>") 'enlarge-window)))

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

;; Install meson-mode
(use-package meson-mode
  :ensure t)

;; (cond
;;  ((eq system-type 'berkeley-unix)
;;   (setq lsp-clients-clangd-executable "clangd19"))
;;  (t
;;   (setq lsp-clients-clangd-executable "clangd")))
(defun lsp-booster--advice-json-parse (old-fn &rest args)
  "Try to parse bytecode instead of json."
  (or
   (when (equal (following-char) ?#)
     (let ((bytecode (read (current-buffer))))
       (when (byte-code-function-p bytecode)
         (funcall bytecode))))
   (apply old-fn args)))
(advice-add (if (progn (require 'json)
                       (fboundp 'json-parse-buffer))
                'json-parse-buffer
              'json-read)
            :around
            #'lsp-booster--advice-json-parse)

(defun lsp-booster--advice-final-command (old-fn cmd &optional test?)
  "Prepend emacs-lsp-booster command to lsp CMD."
  (let ((orig-result (funcall old-fn cmd test?)))
    (if (and (not test?)                             ;; for check lsp-server-present?
             (not (file-remote-p default-directory)) ;; see lsp-resolve-final-command, it would add extra shell wrapper
             lsp-use-plists
             (not (functionp 'json-rpc-connection))  ;; native json-rpc
             (executable-find "emacs-lsp-booster"))
        (progn
          (when-let ((command-from-exec-path (executable-find (car orig-result))))  ;; resolve command from exec-path (in case not found in $PATH)
            (setcar orig-result command-from-exec-path))
          (message "Using emacs-lsp-booster for %s!" orig-result)
          (cons "emacs-lsp-booster" orig-result))
      orig-result)))
(advice-add 'lsp-resolve-final-command :around #'lsp-booster--advice-final-command)
(setq lsp-clients-clangd-executable "clangd")
(setq lsp-clients-clangd-args '("-j=12" "-background-index" "-log=error"))

(use-package rust-mode
  :ensure t)

;; TODO: Use flymake-show-diagnostics-buffer
;; TODO: set up lsp-ivy for find symbol by name
(use-package lsp-mode
  :init
  (setq lsp-keymap-prefix "C-c l")
  :hook (c++-mode . lsp)
  :hook (c-mode . lsp)
  :hook (python-mode . lsp)
  :hook (java-mode . lsp)
  :hook (rust-mode . lsp)
  :bind (("C-q" . lsp-ui-peek-find-definitions)
         ("M-\\" . lsp-find-references)
         ("M-." . lsp-find-definition))
  :commands lsp)

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

;; TODO: Figure out a way to invoke this function every time a C file is opened in /usr/src
(defun bsd ()
  (interactive)
  (c-set-style "bsd")
  (setq indent-tabs-mode t)
  ;; Use C-c C-s at points of source code so see which
  ;; c-set-offset is in effect for this situation
  (c-set-offset 'defun-block-intro 8)
  (c-set-offset 'statement-block-intro 8)
  (c-set-offset 'statement-case-intro 8)
  (c-set-offset 'substatement-open 4)
  (c-set-offset 'substatement 8)
  (c-set-offset 'arglist-cont-nonempty 4)
  (c-set-offset 'inclass 8)
  (c-set-offset 'knr-argdecl-intro 8))

;; TODO stuff for Northguard. Mainly I want to disable whitespace-mode
;; (dir-locals-set-directory-class
;;  (expand-file-name "~/code/cpp/Northguard")
;;  'northguard)

(setq read-process-output-max (* 8 (* 1024 1024))) ;; 8MiB

(use-package org-roam
  :ensure t
  :init
  (setq org-roam-v2-ack t)
  :custom
  (org-roam-directory "~/Notes")
  (org-roam-completion-everywhere t)
  :bind (("C-c n l" . org-roam-buffer-toggle)
         ("C-c n f" . org-roam-node-find)
         ("C-c n i" . org-roam-node-insert)
         :map org-mode-map
         ("C-M-i" . completion-at-point))
  :config (org-roam-setup)
          (setq org-roam-dailies-directory "journal/"))

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
  :ensure t
  :hook (org-mode . org-bullets-mode))
;; also use visual-line-mode
;; also use org-indent-mode

(add-hook 'org-mode-hook (lambda ()
                      (org-indent-mode t)
                      (org-bullets-mode t)
                      (visual-line-mode t)))

(add-hook 'text-mode 'abbrev-mode)
(add-hook 'prog-mode 'abbrev-mode)

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

;;
;; Email setup
;;

;; Generated index like
;; mu init --maildir=$HOME/mail --my-address=kyle@ambroffkao.com --my-address=kyle@ambroff.com --my-address=family@ambroffkao.com --my-address=kyle@buttmail.me --my-address=kyle@2e.rip --my-address=ambroff@fastmail.com --my-address=kyle@segv.zip --my-address=kyle@wrk
(use-package message-view-patch
  :ensure t)

(defun init-mu4e ()
  (setq mu4e-get-mail-command "mbsync -a")
  (require 'mu4e)
  (setq mu4e-change-filenames-when-moving t)
  (setq mu4e-sent-folder "/Sent")
  (setq mu4e-refile-folder "/Archive")
  (setq mu4e-trash-folder "/Trash")
  (setq mu4e-drafts-folder "/Drafts")
  (fset 'my-move-to-trash "mTrash")
  (define-key mu4e-headers-mode-map (kbd "d") 'my-move-to-trash)
  (define-key mu4e-view-mode-map (kbd "d") 'my-move-to-trash))

(setq send-mail-function    'smtpmail-send-it
      smtpmail-smtp-server  "smtp.fastmail.com"
      smtpmail-smtp-service 465
      smtpmail-stream-type  'ssl)

(cond
 ((eq system-type 'darwin)
  (message "Not using mu4e on my work computer"))
 ((eq system-type 'berkeley-unix)
  (let ((os-name (shell-command-to-string "uname")))
    (if (string-match "NetBDS" os-name)
        (message "No mu4e yet on NetBSD")
      (progn
        (add-to-list 'load-path "/usr/local/share/emacs/site-lisp/mu4e")
        (init-mu4e)))))
 ((eq system-type 'gnu/linux)
  (if (file-directory-p "/usr/share/emacs/site-lisp/elpa-src/mu4e-1.12.9")
      (progn
        (add-to-list 'load-path "/usr/share/emacs/site-lisp/elpa-src/mu4e-1.12.9")     
        (init-mu4e))
    (if (file-directory-p "/usr/share/emacs/site-lisp/mu4e")
        (progn
          (add-to-list 'load-path "/usr/share/emacs/site-lisp/mu4e")
          (init-mu4e)))))
  (t
   (message "Need to install mu4e on this platform")))

;; Use copilot if it is available in the vendor directory
(let ((copilot-code-dir (concat (file-name-as-directory prelude-vendor-dir) "copilot.el")))
  (if (file-directory-p copilot-code-dir)
      (progn
        (add-to-list 'load-path copilot-code-dir)
        (require 'copilot)
        (add-hook 'prog-mode 'copilot-mode)
        (add-to-list 'copilot-major-mode-alist '("c-mode" . "c++-mode"))
        (define-key copilot-completion-map (kbd "M-RET") 'copilot-accept-completion))))

;;
;; Some kinda incomplete notes about marginalia and embark setup. Stephan suggested this but I'm not sure I want to use it yet
;;

;; (use-package marginalia
;;   :ensure t
;;   :config
;;   (marginalia-mode))

;; (use-package embark
;;   :ensure t

;;   :bind
;;   (("C-." . embark-act)         ;; pick some comfortable binding
;;    ("C-;" . embark-dwim))       ;; good alternative: M-.

;;   :init

;;   ;; Optionally replace the key help with a completing-read interface
;;   (setq prefix-help-command #'embark-prefix-help-command)

;;   ;; Show the Embark target at point via Eldoc. You may adjust the
;;   ;; Eldoc strategy, if you want to see the documentation from
;;   ;; multiple providers. Beware that using this can be a little
;;   ;; jarring since the message shown in the minibuffer can be more
;;   ;; than one line, causing the modeline to move up and down:

;;   ;; (add-hook 'eldoc-documentation-functions #'embark-eldoc-first-target)
;;   ;; (setq eldoc-documentation-strategy #'eldoc-documentation-compose-eagerly)

;;   :config

;;   ;; Hide the mode line of the Embark live/completions buffers
;;   (add-to-list 'display-buffer-alist
;;                '("\\`\\*Embark Collect \\(Live\\|Completions\\)\\*"
;;                  nil
;;                  (window-parameters (mode-line-format . none)))))

;; ;; Consult users will also want the embark-consult package.
;; (use-package embark-consult
;;   :ensure t ; only need to install it, embark loads it after consult if found
;;   :hook
;;   (embark-collect-mode . consult-preview-at-point-mode))

;; Shell configuration
(use-package vterm
  :ensure t)
(dolist (mode '(term-mode-hook
                vterm-mode-hook
                shell-mode-hook
                treemacs-mode-hook
                eshell-mode-hook))
  (add-hook mode (lambda() (display-line-numbers-mode 0))))

;; Tramp config
(add-to-list 'tramp-remote-path 'tramp-own-remote-path)

;; https://guix.gnu.org/manual/en/html_node/The-Perfect-Setup.html
(let ((guix-repo-dir (file-name-as-directory "~/code/guix/guix")))
  (if (file-directory-p guix-repo-dir)
	  (progn
		(use-package geiser-guile
		  :ensure t)
		(with-eval-after-load 'geiser-guile
		  (add-to-list 'geiser-guile-load-path guix-repo-dir))
		(with-eval-after-load 'yasnippet
		  (add-to-list 'yas-snippet-dirs (concat guix-repo-dir "etc/snippets/yas")))
		(with-eval-after-load 'tempel
		  ;; Ensure tempel-path is a list -- it may also be a string.
		  (unless (listp 'tempel-path)
			(setq tempel-path (list tempel-path)))
		  (add-to-list 'tempel-path (concat guix-repo-dir "etc/snippets/tempel/*")))
		(setq user-full-name "Kyle Ambroff-Kao")
		(setq user-mail-address "kyle@ambroffkao.com")
		(load-file (concat guix-repo-dir "etc/copyright.el"))
		(setq copyright-names-regexp
			  (format "%s <%s>" user-full-name user-mail-address)))))

;; (use-package lsp-sonarlint
;;   :custom
;;   ;; Allow sonarlint to download and unzip the official VSCode extension
;;   ;; If nil, you'll have to do that yourself. See also `lsp-sonarlint-download'
;;   ;; `lsp-sonarlint-download-url' and `lsp-sonarlint-download-dir'
;;   (lsp-sonarlint-auto-download t)

;;   ;; Choose which analyzers you want enabled. By default all are enabled
;;   ;; See command `lsp-sonarlint-available-analyzers' for the full list.
;;   (lsp-sonarlint-enabled-analyzers '("java" "cfamily" "python" "text"))
;;   :ensure t)

(use-package ninja-mode
  :ensure t)

(use-package cmake-mode
  :ensure t)

;; Override some projectile keybindings.
;;
;; I added this after https://github.com/bbatsov/projectile/commit/dd1a8e224dc77 was
;; pulled into my config, because I kinda hate the C-c p c c binding. The comment says
;; he will remove the other bindings like P and C later so I'll have to do the same
;; for those.
(with-eval-after-load 'projectile
  (define-key projectile-command-map (kbd "c") #'projectile-compile-project))

;; (use-package bazel
;;   :ensure t)

(use-package claude-code-ide
  :vc (:url "https://github.com/manzaltu/claude-code-ide.el" :rev :newest)
  :bind ("C-c C-'" . claude-code-ide-menu) ; Set your favorite keybinding
  :config
  (claude-code-ide-emacs-tools-setup)) ; Optionally enable Emacs MCP tools
