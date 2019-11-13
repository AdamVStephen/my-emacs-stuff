;; Keep a log of files modified under Emacs

;; TODO: Make avs-save-log work concurrently from multiple Emacs (i.e. make it an atomic open/append/save/close.

;; TODO: Exclude changes to the FilesModified.log file from the save-log hook
;; TODO: Define the log files as symbols
;; TODO: Exclude successive write log entries to the same file (or provide a view that does this)
;; TODO: Tools for aggregate reports.

(defun avs-save-log ()
     (setq time (current-time-string))
     (setq buff (buffer-file-name))
     (save-excursion
       (setq cl (find-file-noselect "/solhome/astephen/FilesModified.log"))
       (set-buffer cl)
       (goto-char (point-min))
       (insert buff " : " time "\n")
       (save-buffer)
       ))

(defun avs-save-hook ()
  "Add an entry to the FilesModified log recording which files have been changed."  
  (  if (string-match "FilesModified.log" (buffer-name))
      (message "FileModified.log has been updated.")
    (avs-save-log)
    )
  )

(setq after-save-hook (cons 'avs-save-hook after-save-hook))

(defun avs-find-log ()
     (setq time (current-time-string))
     (setq buff (buffer-file-name))
     (save-excursion
       (setq cl (find-file-noselect "/solhome/astephen/FilesConsulted.log"))
       (set-buffer cl)
       (goto-char (point-min))
       (insert buff " : " time "\n")
       (save-buffer)
       ))

(defun avs-find-hook ()
  "Add an entry to the FilesConsulted log recording which files have been read."  
  (  if (string-match "FilesConsulted.log" (buffer-name))
      (message "FilesConsulted.log has been updated.")
    (avs-find-log)
    )
  )

(add-hook 'find-file-hooks 'avs-find-hook)

(message "All file open/save actions will be logged to Solaris files")