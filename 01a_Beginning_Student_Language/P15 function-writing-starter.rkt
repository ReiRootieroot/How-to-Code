;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |P15 function-writing-starter|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;; function-writing-starter.rkt

; 
; PROBLEM:
; 
; Write a function that consumes two numbers and produces the larger of the two. 
; 


(define (foo n1 n2)
  (cond
    [(> n1 n2) n1]
    [(< n1 n2) n2]
    [else n1]  ;;if n1 == n2, print
  )
)

(check-expect (foo 2 3) 3) ;;n2 is bigger than n1
(check-expect (foo 3 2) 3) ;;n1 is bigger than n2
(check-expect (foo 3 3) 3) ;;n2 is equal to n1

(foo 3 5)