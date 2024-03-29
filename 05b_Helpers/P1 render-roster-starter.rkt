;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |P1 render-roster-starter|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;; render-roster-starter.rkt

; Problem:
; 
; You are running a dodgeball tournament and are given a list of all
; of the players in a particular game as well as their team numbers.  
; You need to build a game roster like the one shown below. We've given
; you some constants and data definitions for Player, ListOfPlayer 
; and ListOfString to work with. 
; 
; While you're working on these problems, make sure to keep your 
; helper rules in mind and use helper functions when necessary.
; 
; .
; 


(require 2htdp/image)

;;PLEASE READ COMMENT BOXES BELOW TO UNDERSTAND WHAT WAS WRITTEN AHEAD OF TIME AND GIVEN
;;The constants, data definitions, tests, and the function templates (including the function descriptions) were given.
;;This assignment requires completing function design.


;; Constants
;; ---------

(define CELL-WIDTH 200)
(define CELL-HEIGHT 30)

(define TEXT-SIZE 20)
(define TEXT-COLOR "black")

;; Data Definitions
;; ----------------

(define-struct player (name team))
;; Player is (make-player String Natural[1,2])
;; interp. a dodgeball player. 
;;   (make-player s t) represents the player named s 
;;   who plays on team t
;;

; ;;Given:
; (define P0 (make-player "Samael" 1))
; (define P1 (make-player "Georgia" 2))

(define P0 (make-player "Samael" 1))
(define P1 (make-player "John" 1))
(define P2 (make-player "Brenda" 1))
(define P3 (make-player "Alice" 1))
(define P4 (make-player "Trish" 1))
(define P5 (make-player "Tom" 1))
(define P6 (make-player "Georgia" 2))
(define P7 (make-player "Sally" 2))
(define P8 (make-player "Bob" 2))
(define P9 (make-player "Carl" 2))
(define P10 (make-player "Phil" 2))
(define P11 (make-player "Ellen" 2))


#;
(define (fn-for-player p)
  (... (player-name p)
       (player-team p)))


;; ListOfPlayer is one of:
;; - empty
;; - (cons Player ListOfPlayer)
;; interp.  A list of players.
(define LOP0 empty)                     ;; no players
(define LOP2 (cons P0 (cons P6 empty))) ;; two players
(define fullLOP (cons P0
                       (cons P1
                             (cons P2
                                   (cons P3
                                         (cons P4
                                               (cons P5
                                                     (cons P6
                                                           (cons P7
                                                                 (cons P8
                                                                       (cons P9
                                                                             (cons P10
                                                                                   (cons P11
                                                                                         empty)))))))))))
                  )
)

#;
(define (fn-for-lop lop)
  (cond [(empty? lop) (...)]
        [else
         (... (fn-for-player (first lop))
              (fn-for-lop (rest lop)))]))


;; ListOfString is one of:
;; - empty
;; - (cons String ListOfString)
;; interp. a list of strings containing names
(define LOS0 empty)
(define LOS2 (cons "Samael" (cons "Georgia" empty)))

#;
(define (fn-for-los los)
  (cond [(empty? los) (...)]
        [else
         (... (first los)
              (fn-for-los (rest los)))]))

;; Functions
;; ---------

; PROBLEM 1: 
; 
; Design a function called select-players that consumes a list 
; of players and a team t (Natural[1,2]) and produces a list of 
; players that are on team t.



;;Player ListofPlayers Natural -> ListofString
;;interp. create new list with players on desired team
;;(define (insert player lop t) (cons "tim" empty)) ;;stub
;(check-expect (select-players (cons P6 empty) 2) (cons "Georgia" empty))
;(check-expect (select-players (cons P0 empty) 1) (cons "Samael" empty))
;(check-expect (select-players (cons P6 empty) 1) empty)
;(check-expect (select-players (cons P0 empty) 2) empty)
;(check-expect (select-players (cons P0 (cons P1 empty)) 2) empty)
;(check-expect (select-players (cons P0 (cons P1 empty)) 1) (cons "Samael" (cons "John" empty)))
;(check-expect (select-players (cons P6 (cons P8 empty)) 1) empty)
;(check-expect (select-players (cons P6 (cons P8 empty)) 2) (cons "Georgia" (cons "Bob" empty)))
;(check-expect (select-players (cons P6 (cons P1 empty)) 2) (cons "Georgia" empty))
;(check-expect (select-players (cons P6 (cons P1 empty)) 1) (cons "John" empty))
;(check-expect (select-players (cons P6 (cons P1 (cons P8 empty))) 2) (cons "Georgia" (cons "Bob" empty)))
;(check-expect (select-players (cons P6 (cons P1 (cons P8 empty))) 1) (cons "John" empty))
;
(define (select-players lop t)
  (cond [(empty? lop) empty]
        [else
         (if (team? (first lop) t)
             (cons (player-name (first lop)) (select-players (rest lop) t))
             (select-players (rest lop) t)
         )
        ]
   )
)

;;Player Natural -> Boolean
;;interp. return true if player is on given team t
;;(define (team? player t) true) ;;stub
(define (team? player t2)
  (equal? (player-team player) t2)
)

;(select-players fullLOP 1)
;(select-players fullLOP 2)

; PROBLEM 2:  
; 
; Complete the design of render-roster. We've started you off with 
; the signature, purpose, stub and examples. You'll need to use
; the function that you designed in Problem 1.
; 
; Note that we've also given you a full function design for render-los
; and its helper, render-cell. You will need to use these functions
; when solving this problem.


;; ListOfPlayer -> Image
;; Render a game roster from the given list of players

(check-expect (render-roster empty)
              (beside/align 
               "top"
               (overlay
                (text "Team 1" TEXT-SIZE TEXT-COLOR)
                (rectangle CELL-WIDTH CELL-HEIGHT "outline" TEXT-COLOR))
               (overlay
                (text "Team 2" TEXT-SIZE TEXT-COLOR)
                (rectangle CELL-WIDTH CELL-HEIGHT "outline" TEXT-COLOR))))
                
(check-expect (render-roster LOP2)
              (beside/align 
               "top"
               (above
                (overlay
                 (text "Team 1" TEXT-SIZE TEXT-COLOR)
                 (rectangle CELL-WIDTH CELL-HEIGHT "outline" TEXT-COLOR))
                (overlay
                 (text "Samael" TEXT-SIZE TEXT-COLOR)
                 (rectangle CELL-WIDTH CELL-HEIGHT "outline" TEXT-COLOR)))
               (above
                (overlay
                 (text "Team 2" TEXT-SIZE TEXT-COLOR)
                 (rectangle CELL-WIDTH CELL-HEIGHT "outline" TEXT-COLOR))
                (overlay
                 (text "Georgia" TEXT-SIZE TEXT-COLOR)
                 (rectangle CELL-WIDTH CELL-HEIGHT "outline" TEXT-COLOR)))))


;;(define (render-roster lop) empty-image) ; stub
; ADDED THIS SECTION AS PER INSTRUCTIONS
; 
; (define (render-roster lop)
;   (beside/align "top"
;                (render-team (select-players lop 1) 1)
;                (render-team (select-players lop 2) 2)
;    )
; )
; 
; ;; ListofString Natural -> Image
; ;;interp. render team rosters based on input
; ;;(define (render-team lop team) empty-image)
; (check-expect (render-team (select-players LOP2 1) 1) (above
;                 (overlay
;                  (text "Team 1" TEXT-SIZE TEXT-COLOR)
;                  (rectangle CELL-WIDTH CELL-HEIGHT "outline" TEXT-COLOR))
;                 (overlay
;                  (text "Samael" TEXT-SIZE TEXT-COLOR)
;                  (rectangle CELL-WIDTH CELL-HEIGHT "outline" TEXT-COLOR)))) 
; 
; (define (render-team los team)
;   (above
;    (render-cell (string-append "Team " (number->string team)))
;    (render-los los)
;   )
; )

(define (render-roster lop)
  (beside/align "top"
               (render-team (select-players lop 1) 1)
               (render-team (select-players lop 2) 2)
   )
)

;; ListofString Natural -> Image
;;interp. render team rosters based on input
;;(define (render-team lop team) empty-image)
(check-expect (render-team (select-players LOP2 1) 1) (above
                (overlay
                 (text "Team 1" TEXT-SIZE TEXT-COLOR)
                 (rectangle CELL-WIDTH CELL-HEIGHT "outline" TEXT-COLOR))
                (overlay
                 (text "Samael" TEXT-SIZE TEXT-COLOR)
                 (rectangle CELL-WIDTH CELL-HEIGHT "outline" TEXT-COLOR)))) 

(define (render-team los team)
  (above
   (render-cell (string-append "Team " (number->string team)))
   (render-los los)
  )
)

;; ListOfString -> Image
;; Render a list of strings as a column of cells.
(check-expect (render-los empty) empty-image)
(check-expect (render-los (cons "Samael" empty))
              (above 
               (overlay
                (text "Samael" TEXT-SIZE TEXT-COLOR)
                (rectangle CELL-WIDTH CELL-HEIGHT "outline" TEXT-COLOR))
                     empty-image))
(check-expect (render-los (cons "Samael" (cons "Brigid" empty)))
              (above
                (overlay
                (text "Samael" TEXT-SIZE TEXT-COLOR)
                (rectangle CELL-WIDTH CELL-HEIGHT "outline" TEXT-COLOR))
               (overlay
                (text "Brigid" TEXT-SIZE TEXT-COLOR)
                (rectangle CELL-WIDTH CELL-HEIGHT "outline" TEXT-COLOR))))

;(define (render-los lon) empty-image) ; stub

;; Took Template from ListOfString
(define (render-los los)
  (cond [(empty? los) empty-image]
        [else
         (above (render-cell (first los))
                (render-los (rest los)))]))



;; String -> Image
;; Render a cell of the game table
(check-expect (render-cell "Team 1") 
              (overlay
                 (text "Team 1" TEXT-SIZE TEXT-COLOR)
                 (rectangle CELL-WIDTH CELL-HEIGHT "outline" TEXT-COLOR)))

;(define (render-cell s) empty-image) ; stub

;; Template for String
(define (render-cell s)
  (overlay
   (text s TEXT-SIZE TEXT-COLOR)
   (rectangle CELL-WIDTH CELL-HEIGHT "outline" TEXT-COLOR)))
  


