#lang racket

(require (lib "Graphics.ss" "graphics"))
(open-graphics)
(define ventana (open-viewport "ventana-nombre" 500 500))
(define posy- 250)
(define cuadrado-posn 500)

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

(define (mover-cuadrado n)
  (cond
    [(< n 0)
     (set! posy- (random 500))
     (mover-cuadrado 500)]
    [else
     ((draw-solid-rectangle ventana) (make-posn (+ 10 n) posy-) 20 20 "white")
     ((draw-solid-rectangle ventana) (make-posn n posy-) 20 20 "green")
     (sleep 0.1)
     (mover-cuadrado (- n 10))]))

(define (comenzar-juego posx posy)
  (elipse posx posy "red")
  (thread (lambda () (cambiar-posn posx posy)))
  (mover-cuadrado 500))

(comenzar-juego 250 250)
