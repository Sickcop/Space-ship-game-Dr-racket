#lang racket


(require(lib "Graphics.ss""graphics"))
(open-graphics)
(define ventana (open-viewport "ventana-nombre" 500 500))

#|
(define key-pressed (get-key-press ventana))
(define key-value (key-value key-pressed))
|#

(define (elipse posx posy lado)
  (if (equal? lado 'up)
      (begin
      ((draw-solid-ellipse ventana)(make-posn posx (- posy 10)) 20 20 "red")
      
      (if (equal? lado 'down)
          ((draw-solid-ellipse ventana)(make-posn posx (+ posy 10)) 20 20 "blue")
          (void)
      ))))

 

(define (comenzar-juego n posx posy)
  (define posn-ellipse (make-posn posy posx))

  (define (cambiar-posn)

    (define key-pressed (get-key-press ventana))
    (define key-values (if key-pressed (key-value key-pressed) 'none))
    
    (cond
     [(equal? key-values 'up)
        (begin
        (elipse posx (- posy 10) 'up)
        (cambiar-posn) )]
 
     [(equal? key-values 'down)
        (begin
        (elipse posx (+ posy 10) 'down)
        (cambiar-posn))]))
      
  
  
  
  (cond
    [(= n 20)"end"]
    [else

     ((draw-solid-ellipse ventana)posn-ellipse 20 20 "green")
     (sleep 1)
     ;((draw-viewport ventana) "white")
     (thread cambiar-posn)
     (display "ok")
     (comenzar-juego (+ n 1) posy posx)
          ]
  
  ))

(comenzar-juego 0 250 250)
