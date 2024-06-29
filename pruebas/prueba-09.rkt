#lang racket

(require (lib "Graphics.ss" "graphics"))
(open-graphics)
(define ventana (open-viewport "ventana-nombre" 500 500))
(define posy- 250)
(define cuadrado-posn 500)
(define circle-posn-x 250)
(define circle-posn-y 250)
(define juego-activo #t)

(define (elipse posx posy color)
  ((draw-solid-ellipse ventana) (make-posn posx posy) 20 20 color))

(define (borrar-elipse posx posy)
  ((draw-solid-ellipse ventana) (make-posn posx posy) 20 20 "white"))

(define (cambiar-posn posx posy)

  
  (cond
      [juego-activo
    (define key-pressed (get-key-press ventana))
    (define key-values (if key-pressed (key-value key-pressed) 'none))
    (cond
      [(equal? key-values 'up)
       (borrar-elipse posx posy)
       (let ([new-posy (- posy 10)])
         (elipse posx new-posy "red")
         (set! circle-posn-y new-posy)
         (cambiar-posn posx new-posy))]
      [(equal? key-values 'down)
       (borrar-elipse posx posy)
       (let ([new-posy (+ posy 10)])
         (elipse posx new-posy "blue")
         (set! circle-posn-y new-posy)
         (cambiar-posn posx new-posy))]
      [(equal? key-values 'left)
       (borrar-elipse posx posy)
       (let ([new-posx (- posx 10)])
         (elipse new-posx posy "green")
         (set! circle-posn-x new-posx)
         (cambiar-posn new-posx posy))]
      [(equal? key-values 'right)
       (borrar-elipse posx posy)
       (let ([new-posx (+ posx 10)])
         (elipse new-posx posy "yellow")
         (set! circle-posn-x new-posx)
         (cambiar-posn new-posx posy))]
      [else
       (cambiar-posn posx posy)]
      
      )]))

(define (mover-cuadrado n)
  (cond
    [juego-activo
    (cond
      [(< n 0)
       (set! posy- (random 500))
       (mover-cuadrado 500)]
      [else
       ((draw-solid-rectangle ventana) (make-posn (+ 10 n) posy-) 20 20 "white")
       ((draw-pixmap ventana) nave (make-posn n posy-) 20 20 "green")
       (when (and (= n circle-posn-x) (= posy- circle-posn-y))
         (set! juego-activo #f)
         (displayln "Juego terminado"))
       (sleep 0.1)
       (mover-cuadrado (- n 10))])])
  )

(define (comenzar-juego posx posy)
  (set! circle-posn-x posx)
  (set! circle-posn-y posy)
  (elipse posx posy "red")
  (thread (lambda () (cambiar-posn posx posy)))
  (mover-cuadrado 500))

(comenzar-juego 250 250)
