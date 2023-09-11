;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |P2 nqueens-external-test|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; This file was used in conjunction with the "nqueens-code.rkt" file.
; Said file was fairly complex and made testing individual components difficult without interferring with overall main function.
; 
; The following code was created and then transferred over:
; -"(next--q qpos n)"
; -"(conflicting-queen p1 p2)"
; -"(pos-to-index p b)"
; -"(index-to-pos i n)"


(define-struct pos (x y))
;; Pos is (make-pos Number Number)
;; interp. A cartesian position, x and y are screen coordinates.
;; Pos is Natural[0, n]
;; interp.
;;  the position (0, 0) defines the upper left. The pos increments from left to right and from up to down 
;;  the position in the maze, if the position is p, is defined as follows:
;;    - the row is (<= pos-x (sub1 n))
;;    - the column is (<= pos-y (sub1 n)
(define P1 (make-pos 0 0)) ;;upper left
(define P2 (make-pos 0 4)) ;;lower left for 5x5 maze
(define P3 (make-pos 6 0)) ;;upper right for 7x7 maze

;; QPos is (listof Pos)
;; interp. list of pos that hold queens
;;         Outputs in terms of INDEX
;;         Function "index=to-pos" converts index to the Pos
(define B1 empty)
(define B2 (list (make-pos 0 0))) ;;queen in upper left corner
(define B3 (list (make-pos 0 3) (make-pos 1 1))) ;;queen in upper right corner and center of 4x4 board (NOT A VALID SOLVED BOARD, JUST AN EXAMPLE)
(define B4 (list (make-pos 0 1) (make-pos 1 3) (make-pos 2 0) (make-pos 3 2))) ;;valid solved 4x4 board

;;===============================================================================================
;; FINAL VERSION
; GENERAL "next--q" FUNCTION NOTES
; The logic for "next--q" as called by function is as follows:
; 
; 1. "create-new-entries"
; (add filtered list of queen positions to input list)
;            |
;            v
; 2. "filter/one-queen-conflict"
; (find valid positions by filtering through all available queen positions, using possible queen position)
;            |
;            v
; 3. "andmap/conflicting-queen?"
; (find which individual queen positions are valid, measuring possible queen position against predetermined qpos list)
;          ; |
;            v
; 4. "conflicting-queen?"
; (is given queen position valid against predetermined position from qpos list?)
; 
; 
; PLEASE READ "P3 nqueens-external-test.rkt" FOR MORE DETAILS ON "next--q" FUNCTION

(define (next--q qpos n)
    (local [(define FULLBOARD (build-list (sqr n) identity))
          (define (one-queen-conflict pq)
            (andmap (lambda (set-queen) (conflicting-queen? (index-to-pos set-queen n) (index-to-pos pq n))) qpos)
            )
          (define create-new-entries
            (filter (lambda (possible-queen) (one-queen-conflict possible-queen)) FULLBOARD)
            )
          ]
      (map (lambda (p) (cons p qpos)) create-new-entries)
    )          
  )


; DETAILED "next--q" FUNCTION NOTES
; (please see above for GENERAL notes)
; 
; 1. "create-new-entries"
; "create-new-entries" creates a filtered list of queen positions for each individual element in qpos, the pre-defined, accepted
;    list of queen positions. The map function simply adds each element of "create-new-entries" to qpos for each element of qpos.
; EX.* qpos is (list (list 1) (list 2)) for a 4x4 board.
;      "create-new-entries" finds that for (list 1) and (list 2) that (list 7) and (list 4) are valid positions, respectively.
;      The map function will then output: (list (list 1 7) (list 2 4)).
;  *qpos is not an exact list passed to "next--q"- I'm just using the above as an example. 
;            |
;            v
; 2. "filter/one-queen-conflict"
; "one-queen-conflict" pulls one element (possible-queen) from a generated list of all available queen positions (FULLBOARD) and
;    passes it. FULLBOARD generates a full qpos list based on size of board. What will be returned in this form will be a full list
;    of #t and #f for each individual element of FULLBOARD against the passed position (possible-queen), which the filter function
;    will discard the #f elements. The filter function will check again if all #f elements are discarded with "one-queen-conflict"
;    again. See 3. for details.
; EX. FULLBOARD for a 3x3 board will generate: (list 0 1 2 3 4 5 6 7 8)
;            |
;            v
; 3. "andmap/conflicting-queen?"
; "conflicting-queen?" will take the passed position (pq, standing for "possible-queen") compare it against an element of qpos
;     (set-queen, as the elements in qpos are already pre-defined). Both set-queen and pq are converted from index to pos before
;      being passed. The andmap function will determine whether the list as a whole is either #t or #f (i.e. all elements are #t
;     to be passed as #t).
;          ; |
;            v
; 4. "conflicting-queen?"



;;===============================================================================================
; DETAILED "main--q" FUNCTION NOTES
; The original function structure for "next--q" is given below. All edit changes were made in "next--q". As such, I am keeping
; the below to show the evolution of the function. The notes below only detail the changes between "next--q" and "main--q".
; Please see DETAILED "next--q" FUNCTION NOTES for further details on each step.
; 
; 1. "create-new-entries"
;            |
;            v
; 2. "filter/one-queen-conflict"
; The original code was to pass an element from qpos, not FULLBOARD in the final version. The issue with this configuration is
;    that only the first element of FULLBOARD will be tested against the elements in qpos- NONE OF THE REMAINING ELEMENTS are
;    passed on. If the FULLBOARD element conflicts with the qpos, it will return an empty list. If not, that very same qpos is
;    added to the list and the output will just be repetition of the same element. This is because the filter function works
;    through qpos  (not FULLBOARD), so whatever element is marked #t is in the qpos list.
; EX. qpos is (list (list 0) (list 6)) for a 4x4. FULLBOARD is (list 0 ... 15). The first element (0) conflicts with (list 0),
;    so the element is returned as empty ('()). (list 6) does not conflict, so it will return the same element in qpos.
;    Thus, the output is: (list (list 6 6))
;            |
;            v
; 3. "andmap/conflicting-queen?"
; The function works normally as it is supposed to. loqpos is read as "list of qpos". That is essentially what FULLBOARD is,
;    The actual pre-defined list is qpos.
;          ; |
;            v
; 4. "conflicting-queen?"

(define (main--q qpos n)
  (local [(define FULLBOARD (build-list (sqr n) identity))
          (define (one-queen-conflict p loqpos)
            (andmap (lambda (q) (conflicting-queen? (index-to-pos p n) (index-to-pos q n))) loqpos)
            )
          (define create-new-entries
            (filter (lambda (queen-set) (one-queen-conflict queen-set FULLBOARD)) qpos)
          )
;          (define get-filtered-list
;            (map (lambda (q) (one-queen-conflict q (build-list (sqr n) identity) n)) qpos
;            )
          
;          )
         ]
    (map (lambda (p) (cons p qpos)) create-new-entries)
    )
  )

(define (conflicting-queen? p1 p2)
  (local [(define p1x (pos-x p1))
          (define p1y (pos-y p1))
          (define p2x (pos-x p2))
          (define p2y (pos-y p2))
          ]
    (and (not (equal? p1x p2x))
         (not (equal? p1y p2y))
         (not (equal? (/ (- p2x p1x) (- p2y p1y)) 1))
         (not (equal? (/ (- p2x p1x) (- p2y p1y)) -1))
         )
    )
  )

;; Pos Integer -> Integer
;; interp. convert pos p to an index in the list, based on size of board b
;;(define (pos-to-index p) 0) ;;stub

(define (pos-to-index p b)
  (local [(define s (sqrt b))
          (define x (pos-x p))
          (define y (pos-y p))
         ]
    (+ x (* y s))
  )
)

;; Integer Integer -> Pos
;; interp. convert index i to pos based on board size n
;;(define (index-to-pos i n) (make-pos 0 0)) ;;stub

(define (index-to-pos i n)
  (local [(define (create-pos i s a)
            (local [(define DIFFERENCE (- (add1 i) (* s a)))
                   ]
              (if (<= DIFFERENCE s)
                  (make-pos a (sub1 DIFFERENCE))
                  (create-pos i s (add1 a))
              )
             ) 
            )
         ]
    (create-pos i n 0)
  )
)


(main--q (list 0 5) 4)