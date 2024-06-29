#lang racket

(require (lib "Graphics.ss" "graphics"))
(open-graphics)
(define ventana (open-viewport "ventana-nombre" 500 500))

(define (elipse posx posy color)
  ((draw-solid-ellipse ventana) (make-posn posx posy) 20 20 color))

(define (borrar-elipse posx posy)
  ((draw-solid-ellipse ventana) (make-posn posx posy) 20 20 "white"))

(define (cambiar-posn posx posy)
  (define key-pressed (get-key-press ventana))
  (define key-values (if key-pressed (key-value key-pressed) 'none))
  (cond
    [(equal? key-values 'up)
     (borrar-elipse posx posy)
     (elipse posx (- posy 10) "red")
     (cambiar-posn posx (- posy 10))]
    [(equal? key-values 'down)
     (borrar-elipse posx posy)
     (elipse posx (+ posy 10) "blue")
     (cambiar-posn posx (+ posy 10))]
    [(equal? key-values 'left)
     (borrar-elipse posx posy)
     (elipse (- posx 10) posy "green")
     (cambiar-posn (- posx 10) posy)]
    [(equal? key-values 'right)
     (borrar-elipse posx posy)
     (elipse (+ posx 10) posy "yellow")
     (cambiar-posn (+ posx 10) posy)]
    [else
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

(elipse 250 250 "red")
(comenzar-juego 0 250 250)
