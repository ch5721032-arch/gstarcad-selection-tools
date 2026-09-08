;; select-by-color.lsp - Select all objects with the color of a picked object
;; Command: SELBYCOLOR
(defun c:SELBYCOLOR ( / en col )
  (setq en (entsel "\nPick an object: "))
  (if en
    (progn
      (setq col (cdr (assoc 62 (entget (car en)))))
      (if (null col) (setq col 256))
      (sssetfirst nil (ssget "_X" (list (cons 62 col))))
      (princ (strcat "\nSelected all objects with color " (itoa col) "."))
    )
  )
  (princ)
)
