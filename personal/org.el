(require 'package)

(prelude-require-packages '(use-package org-roam ox-hugo sis))

(setq org-return-follows-link t)

(define-key prelude-mode-map (kbd "C-c n") nil)
(use-package org-roam
  :after org
  :ensure t
  :init
  (setq org-directory (file-truename "~/org")
        org-roam-directory (file-truename "~/org/roam")
        org-roam-completion-everywhere t
        org-roam-db-autosync-mode t)

  :config
  (org-roam-db-autosync-mode)
  (setq org-roam-capture-templates
        '(
          ("n" "note" plain "q%?"
           :target (file+head "pages/notes/%<%Y%m%d%H%M%S>-${slug}.org"
                              "#+SETUPFILE:./hugo_setup.org
#+HUGO_SLUG: ${slug}
#+HUGO_SECTION: notes
#+date: %<%Y-%m-%dT%H:%M:%S>
#+TITLE: ${title}\n")
           :unnarrowed t)
          ("b" "blog" plain "%?"
           :target (file+head "pages/blogs/%<%Y%m%d%H%M%S>-${slug}.org"
                              "#+SETUPFILE:./hugo_setup.org
#+HUGO_SLUG: ${slug}
#+HUGO_SECTION: blog
#+date: %<%Y-%m-%dT%H:%M:%S>
#+TITLE: ${title}\n")
           :unarrowed t)
          ("p" "private" plain "%?"
           :target (file+head "pages/private/%<%Y%m%d%H%M%S>-${slug}.org"
                              "#+TITLE: ${title}\n")
           :unnarrowed t)
          )
        )
  )

(bind-key "C-c n f" #'org-roam-node-find)
(bind-key "C-c n c" #'org-roam-capture)
(bind-key "C-c n i" #'org-roam-node-insert)

(use-package sis
  :demand t
  :config
  (sis-ism-lazyman-config "1" "2" 'fcitx)
  (sis-global-respect-mode t)
  (sis-global-cursor-color-mode t)
  (sis-global-context-mode t)
  (sis-global-inline-mode t)
  )


(use-package evil
  :ensure t
  :init
  (setq evil-want-C-u-scroll t)

  (when evil-want-C-u-scroll
    (define-key evil-insert-state-map (kbd "C-u") 'evil-scroll-up)
    (define-key evil-normal-state-map (kbd "C-u") 'evil-scroll-up)
    (define-key evil-visual-state-map (kbd "C-u") 'evil-scroll-up)
    (define-key evil-motion-state-map (kbd "C-u") 'evil-scroll-up))

  :config
  (evil-mode 1))
