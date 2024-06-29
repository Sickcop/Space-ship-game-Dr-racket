#lang racket

(require(lib "Graphics.ss""graphics"))
(open-graphics)
(define ventana (open-viewport "ventana-nombre" 500 500))

#|
(define key-pressed (get-key-press ventana))
(define key-value (key-value key-pressed))
|#



(define (comenzar-juego n)
  (define posn-ellipse (make-posn 250 230))


    (define key-pressed (get-key-press ventana))
    (define key-values (key-value key-pressed))
  
  
  (cond
    [(= n 20)"end"]
    [else
     (cond
       [(equal? key-values 'release)
        ((draw-ellipse ventana)posn-ellipse 20 20 "green")
        (sleep 1)
        ;((draw-viewport ventana) "white")
        (display "null")
        (comenzar-juego (+ n 1))]

       [(equal? key-values 'up)
        ((draw-ellipse ventana)(make-posn n 100) 20 20 "red")
        (sleep 1)
        ;((draw-viewport ventana) "white")
        (display "up")
        (display n)
        (comenzar-juego (+ n 1))
        ])
     ]))

(comenzar-juego 0)