;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |P2 traffic-light-starter|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

;; traffic-light-starter.rkt

; 
; PROBLEM:
; 
; Design an animation of a traffic light. 
; 
; Your program should show a traffic light that is red, then green, 
; then yellow, then red etc. For this program, your changing world 
; state data definition should be an enumeration.
; 
; Here is what your program might look like if the initial world 
; state was the red traffic light:
; .
; Next:
; .
; Next:
; .
; Next is red, and so on.
; 
; To make your lights change at a reasonable speed, you can use the 
; rate option to on-tick. If you say, for example, (on-tick next-color 1) 
; then big-bang will wait 1 second between calls to next-color.
; 
; Remember to follow the HtDW recipe! Be sure to do a proper domain 
; analysis before starting to work on the code file.
; 
; Note: If you want to design a slightly simpler version of the program,
; you can modify it to display a single circle that changes color, rather
; than three stacked circles. 
; 


;;I'm choosing to put colors in one spot in an effort to save time.


;; =================
;; Constants:
(define WIDTH 200)
(define HEIGHT 200)
(define RADIUS 50) ;;radius of color circles
(define CENTERX (/ WIDTH 2))
(define CENTERY (/ HEIGHT 2))
(define BACKG (empty-scene WIDTH HEIGHT "black")) ;;background
(define RED (circle RADIUS "solid" "red")) ;;red light
(define YELLOW (circle RADIUS "solid" "yellow")) ;;yellow light
(define GREEN (circle RADIUS "solid" "green")) ;;green light


;; =================
;; Data definitions:
;; Light is one of the following:
;; - "red"
;; - "yellow"
;; - "green"
;;interp. color of stoplight

(define (fn-for-light c)
  (cond[(and (>= c 1) (<= c 3)) (...)] ;;red
       [(and (>= c 4) (<= c 6)) (...)] ;;yellow
       [(and (>= c 7) (<= c 9)) (...)] ;;green
  )
)

;; Template rules used:
;;  - one of: 3 cases
;;  - atomic distinct: "red"
;;  - atomic distinct: "yellow"
;;  - atomic distinct: "green"

;; =================
;; Functions:

;; Light -> Light
;; Start the world with "(main <number>)"
;; Any number will do. The number will not have an effect on the function.
;; 
(define (main s)
  (big-bang s
            (on-tick   tickTock 1)     ; Light -> Light
            (to-draw   displayLight)   ; Light -> Image
  )
)

;; Light -> Light
;; produces next state in internal clock
(check-expect (tickTock 3) 4)
(check-expect (tickTock 9) 10)
(check-expect (tickTock 10) 1)


(define (tickTock c)
  (if (>= c 10)
      1               ;;function operates on #'s 1-9. If greater than 10, reset to 1.
      (+ c 1)
  )
)

;; Light -> Image
;; render current state of stoplight
(check-expect (displayLight 3) (place-image RED CENTERX CENTERY BACKG))
(check-expect (displayLight 6) (place-image YELLOW CENTERX CENTERY BACKG))
(check-expect (displayLight 9) (place-image GREEN CENTERX CENTERY BACKG))

(define (displayLight c)
  (cond[(and (>= c 1) (<= c 3)) (place-image RED CENTERX CENTERY BACKG)]
       [(and (>= c 4) (<= c 6)) (place-image YELLOW CENTERX CENTERY BACKG)]
       [else (place-image GREEN CENTERX CENTERY BACKG)]
  )
)
