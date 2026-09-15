(require "grove/grove.scm")
(require "helix/keymaps.scm")

(define (grove-workspace-launch?)
  (let loop ([args (cdr (command-line))])
    (cond
      [(null? args) #f]
      [(equal? (car args) "--") #f]
      [(or (equal? (car args) "-w")
           (equal? (car args) "--working-dir"))
       #t]
      [else (loop (cdr args))])))

(grove-start!
  #:visibility 'always)

(keymap (global)
  (normal
    (space
      (e ":grove-focus!")
      (E ":grove-visibility-toggle!"))))


(require (prefix-in navigator. "hx-tmux-navigator/navigator.scm"))

(keymap (global)
    (insert
      (C-h ":navigator.move-left")
      (C-l ":navigator.move-right")
      (C-j ":navigator.move-down")
      (C-k ":navigator.move-up"))
    (normal
      (C-h ":navigator.move-left")
      (C-l ":navigator.move-right")
      (C-j ":navigator.move-down")
      (C-k ":navigator.move-up")))
