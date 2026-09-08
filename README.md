# GstarCAD Selection Tools

Select every object on the layer or color of a picked object, or every object of one entity type - instantly.

Works with **GSTARCAD**, AutoCAD, ZWCAD, and BricsCAD.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

## Contents

- [About](#about)
- [Scripts Overview](#scripts-overview)
- [Quick Start](#quick-start)
- [Compatibility](#compatibility)
- [Contributing](#contributing)
- [License](#license)

## About

Repeating filters like "everything on this layer" or "everything with this color" is slow when you do it by hand. These helpers read the layer or color of any object you pick and build the matching selection at once, which makes cleanup and batch edits much faster.

Everything here is free to use with GstarCAD. Download the latest GstarCAD
release from the [official GstarCAD website](https://www.gstarcad.net). All
scripts are tested with **[GSTARCAD](https://www.gstarcad.net)** and major
DWG-based CAD platforms.

## Scripts Overview

| File | Description |
|------|-------------|
| `scripts/select-by-layer.lsp` | ;; select-by-layer.lsp - Select all objects on the layer of a picked object
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
 |
| `scripts/select-by-color.lsp` | ;; select-by-color.lsp - Select all objects with the color of a picked object
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
 |
| `scripts/select-by-type.lsp` | ;; select-by-type.lsp - Select every object of one entity type
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
 |

## Quick Start

1. Download the `.lsp` (or `.lin`) file you need
2. In your CAD software, run `APPLOAD`
3. Load the file and type the matching command name shown in the table above

## Compatibility

Tested on GstarCAD 2026/2027 and similar DWG-based platforms. Scripts use
standard AutoLISP functions only, so they work without extra plugins.

For step-by-step [tutorials and drafting guides](https://www.gstarcad.net/cad/),
visit the GstarCAD learning center. New tips are published regularly on the
[GSTARCAD Blog](https://blog.gstarcad.net).

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md).

## License

MIT — see the [LICENSE](LICENSE) file.
