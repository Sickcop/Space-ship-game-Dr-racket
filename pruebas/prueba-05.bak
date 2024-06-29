#lang racket

(require (lib "Graphics.ss" "graphics"))
(open-graphics)
(define ventana (open-viewport "ventana-nombre" 500 500))

(define (elipse posx posy color)
  ((draw-solid-ellipse ventana) (make-posn posx posy) 20 20 color))

(define (cambiar-posn posx posy)
  (define key-pressed (get-key-press ventana))
  (define key-values (if key-pressed (key-value key-pressed) 'none))
  (cond
    [(equal? key-values 'up)
     (elipse posx (- posy 10) "red")
     (cambiar-posn posx (- posy 10))]
    [(equal? key-values 'down)
     (elipse posx (+ posy 10) "blue")
     (cambiar-posn posx (+ posy 10))]
    [else
     ;(display "nada")
     (cambiar-posn posx posy)]))

(define (comenzar-juego n posx posy)
  (cond
    [(= n 20) "end"]
    [else
     ;(elipse posx posy "green")
     
     (sleep 0.1)
     (thread (lambda () (cambiar-posn posx posy)))
     ;((draw-viewport ventana) "white")
     (display "ok")
     (comenzar-juego (+ n 1) posx posy)]))

(comenzar-juego 0 250 250)
