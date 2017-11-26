#lang racket/gui

(require "pdfrender.rkt")

(provide/contract
 [reduce-pages ((or/c path? string?)
                (or/c path? string?) .
                -> . any/c)])
 