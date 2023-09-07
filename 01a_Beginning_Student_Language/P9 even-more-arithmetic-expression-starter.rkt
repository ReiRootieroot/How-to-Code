;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |P9 even-more-arithmetic-expression-starter|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;; foo-evaluation-starter.rkt

; 
; PROBLEM:
; 
; Given the following function definition:
; 
; (define (foo s)
;   (if (string=? (substring s 0 1) "a")
;       (string-append s "a")
;       s))
; 
; Write out the step-by-step evaluation of the expression: 
; 
; (foo (substring "abcde" 0 3))
; 
; Be sure to show every intermediate evaluation step.
; 


(define (foo s)
  (if (string=? (substring s 0 1) "a")
      (string-append s "a")
      s
  )
)

(foo (substring "abcde" 0 3))

;;STEP 1
; Replacing input in function
; 
; (if (string=? (substring "abcde" 0 3) "a")
;       (string-append s "a")
;       s
; )


;;STEP 2
; Determine substring input
; 
; (if (string=? ("abc") "a")
;       (string-append "abc" "a") ;;Replace s with "abc"
;       "abc" ;;Replace s with "abc"
; )


;;STEP 3
; Evaluate expression
; 
; (if (TRUE) ;;Arguments are equal, though different length, because 1st character is the same
;       (string-append "abc" "a")
;       "abc"
; )


;;STEP 4
; Since answer is TRUE, execute the TRUE expression
; 
; (string-append "abc" "a")


;;STEP 5
; Complete final output
; 
; "abca"


;;END OF FILE