# Compound data (structures)

Use structures when two or more values naturally belong together. The `define-struct` goes at the beginning of the data definition, before the types comment.

```racket
(define-struct ball (x y))
;; Ball is (make-ball Number Number)
;; interp. a ball at position x, y 

(define BALL-1 (make-ball 6 10))

(define (fn-for-ball b)
  (... (ball-x b)     ;Number
       (ball-y b)))   ;Number
;; Template rules used:
;;  - compound: 2 fields
```

## References to other data definitions

Some data definitions contain references to other data definitions you have defined (non-primitive data definitions). One common case is for a compound data definition to comprise other named data definitions. In these cases, the template of the first data definition should contain calls to the second data definition's template function wherever the second data appears. 

For example:

```racket
(define-struct game (ball score))
;; Game is (make-game Ball Number) 

;; interp. the current ball and score of the game

(define GAME-1 (make-game (make-ball 1 5) 2))

(define (fn-for-game g)
  (... (fn-for-ball (game-ball g))
       (game-score g)))      ;Number
;; Template rules used:
;;  - compound: 2 fields
;;  - reference: ball field is Ball
```