;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname |P2 replicate-elm-starter|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;; replicate-elm-starter.rkt

; 
; PROBLEM:
; 
; Design a function that consumes a list of elements and a natural n, and produces 
; a list where each element is replicated n times. 
; 
; (replicate-elm (list "a" "b" "c") 2) should produce (list "a" "a" "b" "b" "c" "c")
; 


(check-expect (replicate-elm (list "a" "b" "c") 2) (list "a" "a" "b" "b" "c" "c"))
(check-expect (replicate-elm (list "a" "b" "c") 3) (list "a" "a" "a" "b" "b" "b" "c" "c" "c"))
(check-expect (replicate-elm (list "a" "b" "c") 1) (list "a" "b" "c"))

(define (replicate-elm lox0 n)
  (local [(define (replicate-elm lox acc)
            (cond [(empty? lox) empty]
                  [else
                   (if (not (> acc n))
                        (cons (first lox) (replicate-elm lox (add1 acc)))
                        (replicate-elm (rest lox) 1)
                    )
                  ]
            )
           )
         ]   
    (replicate-elm lox0 1)
 )
)

(replicate-elm (list "a" "b") 2)
