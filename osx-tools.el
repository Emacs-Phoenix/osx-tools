;;
(defun iterm-shell-command (command &optional prefix)
  "cd to `default-directory' then run COMMAND in iTerm.
With PREFIX, cd to project root."
  (interactive (list (read-shell-command
                      "iTerm Shell Command: ")
                     current-prefix-arg))
  (let* ((dir (if prefix (project-root)
                default-directory))
         ;; if COMMAND is empty, just change directory
         (cmd (format "cd %s ;%s" dir command)))
    (do-applescript
     (format
      "
  tell application \"iTerm\"
       activate
       set _session to current session of current terminal
       tell _session
            set command to get the clipboard
            write text \"%s\"
       end tell
  end tell
  " cmd))))

(global-set-key (kbd "C-M-!") #'iterm-shell-command)

;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; open iterm new tab 
;; 
;;;;;;;;;;;;;;;;;;;;;;;;
(defun open-iterm-tab ()
  (interactive)
  (let* ((path (file-name-directory (file-name-directory (or load-file-name buffer-file-name))))
         (script (concat
                  "activate application \"iTerm\"\n"
                  "tell application \"System Events\" to keystroke \"t\" using command down\n"
                  "tell application \"iTerm\" to tell session -1 of current terminal to write text \""
                  path
                  "\"")))
    (start-process "*open-iterm-info*" nil
                   "osascript" "-e"
                   script))
  )

(provide 'osx-tools)
