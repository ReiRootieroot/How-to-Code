;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |P2 nqueens-code|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

; Please read "P3 nqueens-starter.rkt" for details.
; The general text of the required objective is quite detailed and long,
; hence the need to create a new file for the code.
; 
; GOAL:
; Design a function that consumes a "n" amount of chess queens,
; creating one "n" by "n" chess board while making sure that none of the queens attack each
; other.
; 
; Background info:
; The BOARD consists of n^2 individual SQUARES arranged in n rows of n columns.
; A POSITION on the board refers to a specific square.
; A queen ATTACKS every square in its row, its column, and both of its diagonals.
; A board is VALID if none of the queens placed on it attack each other.
; A valid board is SOLVED if it contains n queens.
; 
; There are many strategies for solving nqueens, but you should use the following:
;   
;   - Use a backtracking search over a generated arb-arity tree that
;     is trying to add 1 queen at a time to the board. If you find a
;     valid board with 4 queens produce that result.
; 
;   - You should design a function that consumes a natural - N - and
;     tries to find a solution.


;;=========================================================================
;; Constants:

;;=========================================================================
;; Data definitions:

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

;;=========================================================================
;; Functions:

;; Integer -> QPos
;; determine a solution possible to place queens without any conflict
;; (define (solve-queens n) empty) ;;stub
;   (local [(define (fn-for-x x)
;             (... (fn-for-lox (x-subs x))))
;           (define (fn-for-lox lox)
;             (cond [(empty? lox) false]
;                   [else
;                    (local [(define try (fn-for-x (first lox)))] ;try first child
;                      (if (not (false? try))                     ;successful?
;                          try                                    ;if so produce that
;                          (fn-for-lox (rest lox))))]))]          ;or try rest of children
;     (fn-for-x x)

; TERMINATION ARGUMENT
; TRIVIAL CASE: all queens are placed on board without any conflicts
; REDUCTION STEP: remove squares available once queen is placed, check next square immediately available
; ARGUMENT: as queens are placed, the amount of available squares gradually reduce until all queens are placed
;           IF NO MORE SPACES AVAILABLE WITH QUEENS TO PLACE: board is unsolvable


(define (solve-queens n)
    (local [(define SIZE (sub1 (sqr n)))
            (define (find-pos qpos)
              (if (solved? qpos)
                  qpos
                  (add-queen-pos (next--q qpos n))
              )
            )
            (define (add-queen-pos loqpos)
              (cond [(empty? loqpos) false]
                    [else
                     (local [(define try (find-pos (first loqpos)))] ;try first child
                       (if (not (false? try))                     ;successful?
                           try                                    ;if so produce that
                           (add-queen-pos (rest loqpos))                ;or try rest of children
                        )
                     )
                    ]
                )
             )

            ;; QPos -> Boolean
            ;; interp. determine if a board is solved or not
            (define (solved? qpos) (= (length qpos) n))

            ;; QPos -> (listof QPos)
            ;; interp. generate list of valid queen positions based on present list of queen position bd
            ; "next--q" FUNCTION NOTES
; The logic for "next--q" as called by function is as follows:
; 
; "create-new-entries"
; (add filtered list of queen positions to input list)
;            |
;            v
; "filter/one-queen-conflict"
; (find valid positions by filtering through all available queen positions, using possible queen position)
;            |
;            v
; "andmap/conflicting-queen?"
; (find which individual queen positions are valid, measuring possible queen position against predetermined qpos list)
;          ; |
;            v
; "conflicting-queen?"
; (is given queen position valid against predetermined position from qpos list?)
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

            ;; Pos Pos -> Boolean
            ;; interp. produce true if queen position p2 does not conflict with p1, where p1 is the committed position (i.e. p2 is being tested against p1)
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
            ]
      (find-pos empty)
  )
)

;; 



;; Pos Integer -> Integer
;; interp. convert pos p to an index in the list, based on size of board b
;;(define (pos-to-index p) 0) ;;stub
; (check-expect (pos-to-index (make-pos 3 0) (sqr 4)) 3)
; (check-expect (pos-to-index (make-pos 3 1) (sqr 4)) 7)
; (check-expect (pos-to-index (make-pos 4 4) (sqr 5)) 24)


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
; (check-expect (index-to-pos 1 4) (make-pos 0 1))
; (check-expect (index-to-pos 5 4) (make-pos 1 1))
; (check-expect (index-to-pos 15 4) (make-pos 3 3))
; (check-expect (index-to-pos 7 3) (make-pos 2 1))


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

(solve-queens 6)