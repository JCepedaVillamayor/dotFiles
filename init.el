;; init.el --- Emacs configuration

;; INSTALL PACKAGES
;; --------------------------------------

(require 'package)

(add-to-list 'package-archives
	     '("melpa" . "http://melpa.org/packages/") t)

(add-to-list 'package-archives
             '("marmalade" .
               "http://marmalade-repo.org/packages/"))

(add-to-list 'load-path "~/.emacs.d/lisp/")
(package-initialize)
(when (not package-archive-contents)
  (package-refresh-contents))

(defvar myPackages
  '(;;better-defaults
    elpy ;; add the elpy package
    jedi
    ;; flycheck ;; add the flycheck package
    markdown-mode ;; markdown support for emacs
    virtualenvwrapper
    py-autopep8
    projectile
    helm-projectile
    elscreen
    elixir-mode
    alchemist
    magit
    zoom-window
    use-package
    company-jedi
    emmet-mode
    jinja2-mode
    material-theme
    tree-mode
    ;; bytecomp
    ))

(mapc #'(lambda (package)
          (unless (package-installed-p package)
            (package-install package)))
      myPackages)

;; BASIC CUSTOMIZATION
;; --------------------------------------
(require 'helm-config)

;; Ignore windows enter
(global-set-key [f1] 'ignore)

(setq inhibit-startup-message t) ;; hide the startup message
(load-theme 'material t) ;; load material theme
(global-linum-mode t) ;; enable line numbers globally

;; util shortcuts
(global-set-key (kbd "C-c f") 'projectile-find-file)
(global-set-key (kbd "C-c b") 'projectile-switch-to-buffer)
(global-set-key (kbd "C-c s") 'helm-projectile-grep)
(global-set-key (kbd "C-c u") 'undo-tree-mode)

;; elscreen
(elscreen-start)
(global-set-key (kbd "C-z <right>") 'elscreen-next)
(global-set-key (kbd "C-z <left>") 'elscreen-previous)

;; reload buffer

(defun reload-file ()
  "Revert buffer without confirmation."
  (interactive)
  (revert-buffer :ignore-auto :noconfirm))

;; Zoom windows
(require 'zoom-window)
(global-set-key (kbd "C-c z") 'zoom-window-zoom)

;;(setq zoom-window-use-elscreen t)
(zoom-window-setup)
(setq zoom-window-mode-line-color "firebrick")

;; Originally from stevey, adapted to support moving to a new directory.
(defun rename-file-and-buffer (new-name)
  "Renames both current buffer and file it's visiting to NEW-NAME."
  (interactive
   (progn
     (if (not (buffer-file-name))
         (error "Buffer '%s' is not visiting a file!" (buffer-name)))
     (list (read-file-name (format "Rename %s to: " (file-name-nondirectory
                                                     (buffer-file-name)))))))
  (if (equal new-name "")
      (error "Aborted rename"))
  (setq new-name (if (file-directory-p new-name)
                     (expand-file-name (file-name-nondirectory
                                        (buffer-file-name))
                                       new-name)
                   (expand-file-name new-name)))
  ;; If the file isn't saved yet, skip the file rename, but still update the
  ;; buffer name and visited file.
  (if (file-exists-p (buffer-file-name))
      (rename-file (buffer-file-name) new-name 1))
  (let ((was-modified (buffer-modified-p)))
    ;; This also renames the buffer, and works with uniquify
    (set-visited-file-name new-name)
    (if was-modified
        (save-buffer)
      ;; Clear buffer-modified flag caused by set-visited-file-name
      (set-buffer-modified-p nil))
    (message "Renamed to %s." new-name)))

(global-set-key (kbd "C-x C-r") 'rename-file-and-buffer)

;; Backup files
(setq backup-directory-alist '(("." . "~/emacs-backups")))

;; remove trailing whitespace
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; useful aliases

(defalias 'workon 'venv-workon)
(defalias 'deactivate 'venv-deactivate)
(defalias 'lsvenv 'venv-lsvirtualenv)

;; Projectile
(projectile-global-mode)
(setq projectile-completion-system 'helm)
(helm-projectile-on)

;; PYTHON CONFIG

;; don't save backup files
(setq make-backup-files nil)

(setq venv-location "/home/jcepeda/.virtualenvs/")

;; (elpy-enable)

;;jedi
;; company-mode completion back-end for Python JEDI
;; https://github.com/syohex/emacs-company-jedi

(use-package company-jedi
  :ensure t
  :init
  (setq jedi:tooltip-method nil
        jedi:complete-on-dot t)
  (add-hook 'view-mode-hook (lambda () (flyspell-mode -1)))
  (defun my/python-mode-hook ()
    (add-to-list 'company-backends 'company-jedi)
    (jedi:setup))
  (add-hook 'python-mode-hook 'my/python-mode-hook))

;; jedi config
(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t)

;; Emmet for web editing
(add-hook 'sgml-mode-hook 'emmet-mode) ;; Auto-start on any markup modes
(add-hook 'css-mode-hook  'emmet-mode) ;; enable Emmet's css abbreviation

;; Jinja2 templating for python
(add-hook  'jinja2-mode-hook
           (lambda ()
             (when (require 'auto-complete nil t)
               (auto-complete-mode t))))
(setq auto-mode-alist
      (append '(("\\.html" . jinja2-mode)) auto-mode-alist))

(provide 'init-jinja2-mode)

(company-mode)
(alchemist-mode)
;; init.el ends here
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (company alchemist elixir-mode elixir-mix zoom-window yaml-mode virtualenvwrapper use-package tree-mode py-autopep8 material-theme markdown-mode magit jinja2-mode jedi helm-projectile emmet-mode elscreen elpy company-jedi better-defaults))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
