;; Profile emacs startup timer and gc 
(add-hook 'emacs-startup-hook
  (lambda ()
    (message "*** Emacs loaded in %s with %d garbage collections."
      (format "%.2f seconds"
        (float-time
          (time-substract after-init-time before-init-time)))
       gcs-done)))

;; Revert buffers when the underlying file has changed
(global-auto-revert-mode 1)
