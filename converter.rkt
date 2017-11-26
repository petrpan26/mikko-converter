#lang racket/gui
(require racket-poppler
         racket/draw
         pict) 

(provide pages->pdf)
;;Contract pages|OutputFile|number -> None
;;Output the pages into output directory with
;;magnifying rate of mag
(define (pages->pdf pages output-file [mag 1.0])
  (define first-bitmap (pict->bitmap (page->pict (car pages))))
  (define width (send first-bitmap get-width))
  (define height (send first-bitmap get-height))
  (define dc
    (new pdf-dc%
         [ interactive #f ]
         [ use-paper-bbox #f ]
         [ width (* mag width)]   ; Default scale is 1.0
         [ height (* mag height)]
         [ output output-file ]
         [ as-eps #f]))

  (send* dc
    (scale mag mag)
    (start-doc "useless string"))
  (for ([i pages])
    (send* dc (start-page))
    (page-render-to-dc! i dc)
    (send* dc (end-page)))
  (send* dc
    (end-doc)))