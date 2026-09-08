;; select-by-type.lsp - Select every object of one entity type
;; Command: SELTYPE
;; Usage: SELTYPE -> pick the type from the prompt
(defun c:SELTYPE ( / typ ss n )
  (initget "LINE ARC CIRCLE TEXT INSERT LWPOLYLINE")
  (setq typ (getkword "\nType [LINE/ARC/CIRCLE/TEXT/INSERT/LWPOLYLINE]: "))
  (if typ
    (progn
      (setq ss (ssget "_X" (list (cons 0 typ)))
            n (if ss (sslength ss) 0))
      (if ss
        (sssetfirst nil ss)
      )
      (princ (strcat "\nSelected " (itoa n) " " typ " objects."))
    )
  )
  (princ)
)
