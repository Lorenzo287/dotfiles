(progn
  (vhdl-mode)
  (defun basic-save-buffer (&optional arg) (message "Skip save"))
  (setq vhdl-basic-offset 4
        vhdl-upper-case-keywords t
        vhdl-upper-case-types t
        vhdl-upper-case-attributes t)
  (vhdl-beautify-buffer)
  (princ (buffer-string)))
