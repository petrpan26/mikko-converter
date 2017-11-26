#lang racket/gui
(require racket-poppler
         racket/draw
         "converter.rkt"
         slideshow/pict)
(provide reduce-pages)
;;Contract pdf | nat -> pages
;;Define a list of page from a pdf-file
(define (make-pages x [cur 0])
  (if (= cur (pdf-count-pages x))
  	empty
  	(cons (pdf-page x cur) (make-pages x (add1 cur)))))
;;Contract nat|pages -> page
;;Get the x-th page from pages
(define (get-page x pages)
	(if (= x 0)
		(car pages)
		(get-page (sub1 x) (cdr pages))))
;;Contract: StringList|StringList -> Bool
;;Check if there's a monotonic subsequence of stA in stB
(define (helper-subset? stA stB)
  (if (empty? stA)
      true
      (if (empty? stB)
          false
          (if (eq? (car stA) (car stB))
              (helper-subset? (cdr stA) (cdr stB))
              (helper-subset? stA (cdr stB))))))
;;Contract: page|page -> bool
;;Reture true if content of page A is contain fully in B
(define (subset? a b)
  (define textA (string->list (page-text a)))
  (define textB (string->list (page-text b)))
  (if (empty? textA) false
      (helper-subset? textA textB)))

;;Contract: pages->pages
;;Filter the slides so there are no redundant slides
(define (filter-pages pages [new empty])
  (if (empty? pages)
      new
      (if (empty? new)
          (filter-pages (cdr pages) (cons (car pages) new))
          (if (subset? (car new) (car pages))
              (filter-pages (cdr pages) (cons (car pages) (cdr new)))
              (filter-pages (cdr pages) (cons (car pages) new))))))
;;Contract: SourceFile|OutputFile|mag
;;Take the pdf in the source directory and produce a
;;reduced version in ouput directory with magnifying rate
(define (reduce-pages x y)
  (define doc (make-pages (open-pdf x)))
  (define result (reverse (filter-pages doc)))
  (pages->pdf result y))
