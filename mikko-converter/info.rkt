#lang setup/infotab
(define name "mikko-converter")
(define blurb
  '("Reduce the redundant pages of Mikko Econ 101 Slides."))
(define primary-file "main.rkt")
(define repositories '("1.x"))
(define categories '(media io))
; (define scribblings '(("doc/main.scrbl" ())))
; (define scribblings '(("doc/main.scrbl" ())))
(define release-notes '((p "Initial release")))
(define omit-compile-paths '("mikko-converter/examples/" "examples/"))