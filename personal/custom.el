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
   '(gradle-mode json-mode dockerfile-mode scala-mode afternoon-theme csv-mode smart-tabs-mode lsp-treemacs lsp-python-ms yasnippet-lean yaml-mode use-package lsp-ui yasnippet company-lsp lsp-mode cmake-mode exec-path-from-shell zop-to-char zenburn-theme which-key volatile-highlights undo-tree super-save smartrep smartparens operate-on-number move-text magit projectile imenu-anywhere hl-todo guru-mode gitignore-mode gitconfig-mode git-timemachine gist flycheck expand-region epl editorconfig easy-kill diminish diff-hl discover-my-major crux browse-kill-ring beacon anzu ace-window))
 '(pdf-view-midnight-colors '("#DCDCCC" . "#383838"))
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

(set-variable 'projectile-globally-ignored-directories '(".idea" ".ensime_cache" ".eunit" ".git" ".hg" ".fslckout" "_FOSSIL_" ".bzr" "_darcs" ".tox" ".svn" ".stack-work" ".clangd"))

;; C++ dev setup
(c-set-offset 'innamespace 0)

(setq c-default-style "linux"
      c-basic-offset 4
      tab-width 4
      indent-tabs-mode t)

(eval-after-load 'company
  '(add-to-list 'company-backends 'company-lsp))

;; (use-package lsp-mode
;;   :hook (c++-mode . lsp)
;;   :hook (c-mode . lsp)
;;   :hook (python-mode . lsp)
;;   :commands lsp
;;   :config
;;   (setq lsp-clients-clangd-args '("-j=3" "-background-index" "-log=error")))

;; (use-package lsp-ui :commands lsp-ui-mode)
;; (use-package company-lsp :commands company-lsp)

(eval-after-load "c++-mode"
  '(define-key c-mode-base-map (kbd "M-/")
     (function lsp-find-references)))
(require 'cc-mode)
(define-key c-mode-base-map (kbd "M-\\")
  (function lsp-find-references))


(company-mode t)
(ido-mode t)
(show-paren-mode t)
(setq global-hl-line-mode nil)
(scroll-bar-mode -1)

(global-set-key (kbd "<f5>") 'compile)

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
