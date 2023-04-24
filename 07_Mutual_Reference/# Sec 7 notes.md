# Self-referential or Mutually Referential Data Definitions

When dealing with arbitrary amounts of information, a well-formed self-referential or mutually referential data definition is necessary. In order to be well-formed, a self-referential data definition must have at least one case without self-reference (the base case(s)), and at least one case with self-reference. The template should include a base case that corresponds to the non-self-referential clause(s) as well as one or more natural recursions that correspond to the self-referential clauses.

## Example: ListOfString

```racket
;; ListOfString is one of:
;;  - empty
;;  - (cons String ListOfString)
;; interp. a list of strings

(define LOS-1 empty)
(define LOS-2 (cons "a" empty))
(define LOS-3 (cons "b" (cons "c" empty)))

(define (fn-for-los los)
  (cond [(empty? los) (...)]                   ; BASE CASE
        [else (... (first los)                 ; String
                   (fn-for-los (rest los)))])) ; NATURAL RECURSION
;;             /
;;            /
;;       COMBINATION
;; Template rules used:
;;  - one of: 2 cases
;;  - atomic distinct: empty
;;  - compound: (cons String ListOfString)
;;  - self-reference: (rest los) is ListOfString
```

## Example: Dot

```racket
(define-struct dot (x y))
;; Dot is (make-dot Integer Integer)
;; interp. A dot on the screen, w/ x and y coordinates.
(define D1 (make-dot 10 30))

(define (fn-for-dot d)
  (... (dot-x d)   ; Integer
       (dot-y d))) ; Integer
;; Template rules used:
;;  - compound: 2 fields
```

## Example: ListOfDot

```racket
;; ListOfDot is one of:
;;  - empty
;;  - (cons Dot ListOfDot)
;; interp. a list of Dot
(define LOD1 empty)
(define LOD2 (cons (make-dot 10 20) (cons (make-dot 3 6) empty)))

(define (fn-for-lod lod)
  (cond [(empty? lod) (...)]
        [else
         (... (fn-for-dot (first lod))
              (fn-for-lod (rest lod)))]))
;; Template rules used:
;;  - one of: 2 cases
;;  - atomic distinct: empty
;;  - compound: (cons Dot ListOfDot)
;;  - reference: (first lod) is Dot 
;;  - self-reference: (rest lod) is ListOfDot
```