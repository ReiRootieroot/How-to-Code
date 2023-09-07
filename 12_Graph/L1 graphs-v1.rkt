;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname |L1 graphs-v1 txt|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))

;; graphs-v1.rkt

; 
; PROBLEM: 
; 
; Imagine you are suddenly transported into a mysterious house, in which all
; you can see is the name of the room you are in, and any doors that lead OUT
; of the room.  One of the things that makes the house so mysterious is that
; the doors only go in one direction. You can't see the doors that lead into
; the room.
; 
; Here are some examples of such a house:
; 
; ; .
;    ; .
;    ; .
;     ; .
; 
; 
; In computer science, we refer to such an information structure as a directed
; graph. Like trees, in directed graphs the arrows have direction. But in a
; graph it is  possible to go in circles, as in the second example above. It
; is also possible for two arrows to lead into a single node, as in the fourth
; example.
; 
;    
; Design a data definition to represent such houses. Also provide example data
; for the four houses above.
; 


(define-struct room (name exits))
;; Room is (make-room String (listof Room))
;; interp. room's name and list of rooms exits lead out to

; .

(define H1 (make-room "A" (list (make-room "B" empty))))

  ; .

;;Last "-0-" is the result of make-room expression for A
;;Inside double (), "-0-" is associated with the (make-room "A" ...) expression
;;Essentially, when Racket computes the "-0-" term inside (list...), it'll refer back to the prior term of "-0-" (the double ()'s)
(define H2
  (shared ((-0- (make-room "A" (list (make-room "B" (list -0-))))))
    -0-)
)

  ; .

#;
(define H3
  (shared ((-0-
            (make-room "A" (list
                            (make-room "B" (list
                                            (make-room "C" (list -0-))))))))
    -0-)
)

(define H3
  (shared (
           (-A- (make-room "A" (list -B-)))
           (-B- (make-room "B" (list -C-)))
           (-C- (make-room "C" (list -A-)))
          )
    -A-)
)

; .


(define H4
  (shared (
           (-A- (make-room "A" (list -B- -D-)))
           (-B- (make-room "B" (list -C- -E-)))
           (-C- (make-room "C" (list -B-)))
           (-D- (make-room "D" (list -E-)))
           (-E- (make-room "E" (list -A- -F-)))
           (-F- (make-room "C" (list)))
          )
    -A-)
)

;; template: structural recursion, encapsulate w/ local, tail-recursive w/ worklist,
;;           context-preserving accumulator what rooms have been visited

(define (fn-for-nouse r0)
  ;;todo is (listof Room); a worklist accumulator
  ;;visited is (listof String); context-preserving accumulator, names of room already visited
  (local [(define (fn-for-room r todo visited)
            (if (member (room-name r) visited)
                (fn-for-lor todo visited)
                (fn-for-lor (append (room-exits r) todo)
                            (cons (room-name r) visited)
                )
            )
          )
          (define (fn-for-lor todo visited)
            (cond [(empty? todo) ...]
                  [else
                   (fn-for-room (first todo) (rest todo) visited)
                  ]
           )
          )
         ]
    (fn-for-room r0 empty empty)
  )
)