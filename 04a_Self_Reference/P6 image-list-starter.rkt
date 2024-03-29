;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |P6 image-list-starter|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)

;; image-list-starter.rkt

;; =================
;; Data definitions:

; 
; PROBLEM A:
; 
; Design a data definition to represent a list of images. Call it ListOfImage. 
; 


;; ListOfImage is one of:
;;  - empty
;;  - (cons Image ListOfImage)
;; interp. a list of images
(define LOI1 empty)
(define LOI2 (cons . (cons . empty)))
(define LOI3 (cons . (cons .  (cons . empty))))
#;
(define (fn-for-loi loi)
  (cond [(empty? loi) (...)]
        [else
         (... (first loi)
              (fn-for-loi (rest loi)))]))

;; Template rules used:
;;  - one of: 2 cases
;;  - atomic distinct: empty
;;  - compound: (cons Number ListOfImage)
;;  - self-reference: (rest lon) is ListOfImage

;; =================
;; Functions:

; 
; PROBLEM B:
; 
; Design a function that consumes a list of images and produces a number 
; that is the sum of the areas of each image. For area, just use the image's 
; width times its height.
; 


(check-expect (area? LOI1) empty)
(check-expect (area? LOI2) (cons 5300 (cons 7548 empty)))
(check-expect (area? LOI3) (cons 5300 (cons 7548 (cons 7744 empty))))

(define (area? loi)
  (cond [(empty? loi) empty]
        [else
         (cons (* (image-height (first loi)) (image-width (first loi))) (area? (rest loi)))
        ]
   )
)

(area? LOI2)
(area? LOI3)
