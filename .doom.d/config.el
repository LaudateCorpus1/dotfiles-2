;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-
;; User Information
(setq user-full-name "Carson Freedman"
      user-mail-address "carsin@users.noreply.github.com")

(setq comp-speed 2)
(setq-default delete-by-moving-to-trash t                 ; Delete files to trash
              indent-tabs-mode nil                        ; Don't use tabs
              tab-width 4                                 ; Set width for tabs
              uniquify-buffer-name-style 'forward         ; Uniquify buffer names
              window-combination-resize t                 ; take new window space from all other windows (not just current)
              x-stretch-cursor t)                         ; Stretch cursor to the glyph width

(setq undo-limit 80000000                         ; Raise undo-limit to 80Mb
      evil-want-fine-undo t                       ; By default while in insert all changes are one big blob. Be more granular
      ;; evil-cross-lines t                          ; Makes horizontal movement not stop at EOL
      default-directory: "~"                      ; Home :)
      company-idle-delay nil                      ; No delay for autocomplete
      lsp-ui-sideline-enable nil
      load-prefer-newer t
      lsp-enable-symbol-highlighting nil
      auto-save-default t)                        ; Nobody likes to lose work, I certainly don't

(delete-selection-mode 1)                         ; Replace selection when inserting text
(global-subword-mode 1)                           ; Iterate through CamelCase words
(auto-save-visited-mode +1)                       ; Enable autosaving on all buffers opened

;; Maximize Emacs window on startup
(add-to-list 'default-frame-alist '(fullscreen . maximized))

;; Font settings
(setq doom-font (font-spec :family "Menlo" :size 14)
      doom-variable-pitch-font (font-spec :family "Monaco" :size 10)
      doom-serif-font (font-spec :family "New York" :size 12)
      doom-big-font (font-spec :family "Menlo" :size 20))

;; Set theme
(setq doom-theme 'doom-nord)

;; Configure org settings
(after! org
        (setq org-directory "~/org/"
              org-ellipsis " ... "
              org-roam-tag-sources '(prop last-directory)
              org-roam-directory "~/org/notes/"
              ;; deft-directory "~/org/notes/"
              org-roam-db-location "~/.emacs.d/roam.db"
              org-journal-file-type 'daily
              org-journal-date-prefix "#+title: Journal: "
              org-journal-file-format "%Y-%m-%d.org"
              org-journal-dir "~/org/notes/"
              org-journal-time-format "%I:%M %p"
              org-journal-date-format "%A, %d %B %Y"
              org-log-done 'time
              ;; org-agenda-skip-scheduled-if-done t
              ;; org-agenda-skip-deadline-if-done t
              ;; org-agenda-include-deadlines t
              ;; org-agenda-block-separator nil
              ;; org-agenda-tags-column 100
              ;; org-agenda-compact-blocks t
              org-hide-emphasis-markers t
              ;; org-pretty-entities t
              ;; org-use-sub-superscripts t
              org-todo-keywords '((sequence "TODO(t)" "WAITING(w)" "INPROGRESS(i)" "|" "DONE(d)" "CANCELLED(c)"))
              ))

;; set up agenda location
(setq org-agenda-files '("~/org/gtd/inbox.org"
                         "~/org/gtd/todo.org"
                         "~/org/gtd/projects.org"
                         "~/org/gtd/someday.org"
                         "~/org/gtd/tickler.org"))

(setq org-refile-targets '(("~/org/gtd/projects.org" :maxlevel . 3)
                           ("~/org/gtd/inbox.org" :level . 2)
                           ("~/org/gtd/todo.org" :level . 1)
                           ("~/org/gtd/someday.org" :level . 1)
                           ("~/org/gtd/tickler.org" :maxlevel . 2)))

(setq org-capture-templates '(("t" "Todo [inbox]" entry
                               (file+headline "~/org/gtd/inbox.org" "Tasks")
                               "* TODO %i%?")
                              ("T" "Tickler" entry
                               (file+headline "~/org/gtd/tickler.org" "Tickler")
                               "* %i%? \n %U")))

(add-to-list 'safe-local-variable-values
             '(org-roam-directory . "."))

;; Show absolute line numbering
(setq display-line-numbers-type t)

;; Split to bottom and right always
(setq evil-vsplit-window-right t
      evil-split-window-below t)

;; Buffer previews in ivy
(setq +ivy-buffer-preview t)

(defun doom-modeline-conditional-buffer-encoding ()
  ;; We expect the encoding to be LF UTF-8, so only show the modeline when this is not the case
  (setq-local doom-modeline-buffer-encoding
              (unless (or (eq buffer-file-coding-system 'utf-8-unix)
                          (eq buffer-file-coding-system 'utf-8)))))
(add-hook 'after-change-major-mode-hook #'doom-modeline-conditional-buffer-encoding)

;; Navigate by visual line
(define-key evil-normal-state-map (kbd "<remap> <evil-next-line>") 'evil-next-visual-line)
(define-key evil-normal-state-map (kbd "<remap> <evil-previous-line>") 'evil-previous-visual-line)
(define-key evil-motion-state-map (kbd "<remap> <evil-next-line>") 'evil-next-visual-line)
(define-key evil-motion-state-map (kbd "<remap> <evil-previous-line>") 'evil-previous-visual-line)

(setq rustic-lsp-server 'rls)
(setq python-shell-interpreter "python3")

(defun set-frame-size-according-to-resolution ()
  (interactive)
  (if window-system
  (progn
    ;; use 120 char wide window for largeish displays
    ;; and smaller 80 column windows for smaller displays
    ;; pick whatever numbers make sense for you
    (if (> (x-display-pixel-width) 1280)
           (add-to-list 'default-frame-alist (cons 'width 120))
           (add-to-list 'default-frame-alist (cons 'width 80)))
    ;; for the height, subtract a couple hundred pixels
    ;; from the screen height (for panels, menubars and
    ;; whatnot), then divide by the height of a char to
    ;; get the height we want
    (add-to-list 'default-frame-alist
         (cons 'height (/ (- (x-display-pixel-height) 200)
                             (frame-char-height)))))))

(set-frame-size-according-to-resolution)
