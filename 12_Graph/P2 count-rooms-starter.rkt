;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname |P2 count-rooms-starter txt|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))

;; count-rooms-starter.rkt

; 
; PROBLEM:
; 
; Using the following data definition, design a function that consumes a room and produces 
; the total number of rooms reachable from the given room. Include the starting room itself. 
; Your function should be tail recursive, but you should not use the primitive length function.
; 


;; Data Definitions: 

(define-struct room (name exits))
;; Room is (make-room String (listof Room))
;; interp. the room's name, and list of rooms that the exits lead to

; .
 
(define H1 (make-room "A" (list (make-room "B" empty))))

; .
 
(define H2 
  (shared ((-0- (make-room "A" (list (make-room "B" (list -0-))))))
    -0-)) 


; .

(define H3
  (shared ((-A- (make-room "A" (list -B-)))
           (-B- (make-room "B" (list -C-)))
           (-C- (make-room "C" (list -A-))))
    -A-))
           


; .

(define H4
  (shared ((-A- (make-room "A" (list -B- -D-)))
           (-B- (make-room "B" (list -C- -E-)))
           (-C- (make-room "C" (list -B-)))
           (-D- (make-room "D" (list -E-)))
           (-E- (make-room "E" (list -F- -A-)))
           (-F- (make-room "F" (list))))
    -A-))

;; template: structural recursion, encapsulate w/ local, tail-recursive w/ worklist, 
;;           context-preserving accumulator what rooms have we already visited 

(define (fn-for-house r0)
  ;; todo is (listof Room); a worklist accumulator
  ;; visited is (listof String); context preserving accumulator, names of rooms already visited
  (local [(define (fn-for-room r todo visited) 
            (if (member (room-name r) visited)
                (fn-for-lor todo visited)
                (fn-for-lor (append (room-exits r) todo)
                            (cons (room-name r) visited)))) ; (... (room-name r))
          (define (fn-for-lor todo visited)
            (cond [(empty? todo) (...)]
                  [else
                   (fn-for-room (first todo) 
                                (rest todo)
                                visited)]))]
    (fn-for-room r0 empty empty)))
;;================================================================================================

;; Room -> Integer
;; interp. count how many rooms can be reached based on room r0
(define (total-reachable r0)
  ;; todo is (listof Room); a worklist accumulator
  ;; visited is (listof String); context preserving accumulator, names of rooms already visited
  ;; rooms-seen is Integer; counting accumulator, to check to see how many rooms were visited
  (local [(define (fn-for-room r todo visited rooms-seen) 
            (if (member (room-name r) visited)
                (fn-for-lor todo visited rooms-seen)
                (fn-for-lor (append (room-exits r) todo)
                            (cons (room-name r) visited)
                            (add1 rooms-seen))))
          (define (fn-for-lor todo visited rooms-seen)
            (cond [(empty? todo) rooms-seen]
                  [else
                   (fn-for-room (first todo) 
                                (rest todo)
                                visited rooms-seen)]))]
    (fn-for-room r0 empty empty 0)))

(total-reachable H4)
