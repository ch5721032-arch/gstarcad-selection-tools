;; select-by-layer.lsp - Select all objects on the layer of a picked object
;; Command: SELBYLAYER
;; Usage: APPLOAD -> SELBYLAYER -> pick one object
(defun c:SELBYLAYER ( / en lay )
  (setq en (entsel "\nPick an object: "))
  (if en
    (progn
      (setq lay (cdr (assoc 8 (entget (car en)))))
      (sssetfirst nil (ssget "_X" (list (cons 8 lay))))
      (princ (strcat "\nSelected all objects on layer \"" lay "\"."))
    )
  )
  (princ)
)
