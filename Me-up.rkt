#lang racket

;Juan Manuel Hurtado Isaza
;Kelly Palacio Marulanda
;Freddy Alejandro Aristizabal
;Santiago Alvarez

(require (lib "Graphics.ss" "graphics"))
(open-graphics)
(define ventana (open-viewport "Me-Up" 500 500 ))

;variables globales

((draw-viewport ventana) "green")
(define posy- 250)
(define cuadrado-posn 500)
(define circle-posn-x 250)
(define circle-posn-y 250)
(define juego-activo #t)
(define hitbox-tolerance 100)
(define puntaje 0)
(define nave "./nave.png")
(define alien "./alien.png")

;dibujar elpise

(define (elipse posx posy)
  ((draw-pixmap ventana) nave (make-posn posx posy)))

;borrar elipse

(define (borrar-elipse posx posy)
  ((draw-solid-rectangle ventana) (make-posn posx posy) 127 107 "black"))

;cambiar posicion nave

(define (cambiar-posn posx posy);ESTA FUNCION SE LLAMA EN SEGUNDO PLANO DE EJECUCION PARA NO DETENER EL PROGRAMA
  ;MIENRAS ESPERA POR LA TECLA QUE SE TIENE QUE PRESIONAR
  (cond
      [juego-activo
    (define key-pressed (get-key-press ventana))  
    (define key-values (if key-pressed (key-value key-pressed) 'none));consigue el valor en simbolo presionado y si no hay valor devuelv 'none
    (cond
      ;se compara el valor obtenido en key-values
      [(equal? key-values 'up)
       (cond
         [(< posy 0)(borrar-elipse posx posy);define el rango de mivimiento desde 0
       (define new-posy (+ posy 10));define la nueva posicion sumando 10 unidades
         (elipse posx new-posy);vuelve a dibujar la elipse en la nueva posicion y
         (set! circle-posn-y new-posy);controla la posicion de la nave para verificar una posible colision
         
         (cambiar-posn posx new-posy)];FUNCION O LLAMADA RECURSIVA-----------------------------------------------
         
         [else
          (borrar-elipse posx posy);borra el rastro de la elipse
          (define new-posy (- posy 10))
          (elipse posx new-posy)
          (set! circle-posn-y new-posy)
          (cambiar-posn posx new-posy)])];FUNCION O LLAMADA RECURSIVA-----------------------------------------------
      
      [(equal? key-values 'down)

       (cond
         [(> posy 390)(borrar-elipse posx posy)
          (define new-posy (- posy 10))
          (elipse posx new-posy)
          (set! circle-posn-y new-posy)
          (cambiar-posn posx new-posy)];FUNCION O LLAMADA RECURSIVA-----------------------------------------------
         [else
          (borrar-elipse posx posy)
          (define new-posy (+ posy 10))
          (elipse posx new-posy)
          (set! circle-posn-y new-posy)
          (cambiar-posn posx new-posy)])];FUNCION O LLAMADA RECURSIVA-----------------------------------------------
      
      [(equal? key-values 'left)

       (cond
         [(< posx 0)(borrar-elipse posx posy)
          (define new-posx (+ posx 10))
          (elipse new-posx posy)
          (set! circle-posn-x new-posx)
          (cambiar-posn new-posx posy)] ;FUNCION O LLAMADA RECURSIVA-----------------------------------------------
         [else
          (borrar-elipse posx posy)
          (define new-posx (- posx 10))
          (elipse new-posx posy)
          (set! circle-posn-x new-posx)
          (cambiar-posn new-posx posy)])];FUNCION O LLAMADA RECURSIVA-----------------------------------------------
      
      [(equal? key-values 'right)
       (cond
         [(> posx 390)(borrar-elipse posx posy)
          (define new-posx (- posx 10))
          (elipse new-posx posy)
          (set! circle-posn-x new-posx)
          (cambiar-posn new-posx posy)];FUNCION O LLAMADA RECURSIVA-----------------------------------------------
         [else
          (borrar-elipse posx posy)
          (define new-posx (+ posx 10))
          (elipse new-posx posy)
          (set! circle-posn-x new-posx)
          (cambiar-posn new-posx posy)])];FUNCION O LLAMADA RECURSIVA-----------------------------------------------
      [else
       (cambiar-posn posx posy)])]));FUNCION O LLAMADA RECURSIVA-----------------------------------------------

(define (colision? x1 y1 x2 y2 tolerance)
  (and (<= (abs (- x1 x2)) tolerance)
       (<= (abs (- y1 y2)) tolerance)))

(define (mover-cuadrado n)
  (cond
    [juego-activo
    (cond
      [(< n -110)
       (set! posy- (random 480))
       (mover-cuadrado 500)];FUNCION O LLAMADA RECURSIVA-----------------------------------------------
      [else
       (set! puntaje (+ puntaje 1));contador del puntaje en cada iteracion
       (display "Score: ")
       (displayln puntaje)
       ((draw-solid-rectangle ventana) (make-posn (+ 10 n) posy-) 104 104 "black");se borra el rastro del alien
       ((draw-pixmap ventana) alien (make-posn n posy-))
        (cond
         [(colision? n posy- circle-posn-x circle-posn-y hitbox-tolerance);se llama la colision con las posiciones y tolerancia definidas
         (set! juego-activo #f);se cambia el valor de verdad a falso de juego activo por ende, el juego para
         (displayln "Juego terminado")])
       (sleep 0.1)
       (mover-cuadrado (- n 10))])]));FUNCION O LLAMADA RECURSIVA-----------------------------------------------

(define (comenzar-juego posx posy)
  (set! circle-posn-x posx)
  (set! circle-posn-y posy)
  (elipse posx posy)
  ;SE UTILIZA LAMBDA PORQUE THREAD SOLAMENTE RECIBE UN ARGUMENTO
  (thread (lambda () (cambiar-posn posx posy)));Divide el hilo de ejecucion de cambiar-posn para no detener el
  ;programa mientras se presiona una tecla
  (mover-cuadrado 500))

(comenzar-juego 250 250)
