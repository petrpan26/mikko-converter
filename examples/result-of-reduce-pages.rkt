#lang racket

(require mikko-converter)

(define path-to-pdf "test.pdf")
(define path-to-output "output.pdf")
(reduce-pages path-to-pdf path-to-output)