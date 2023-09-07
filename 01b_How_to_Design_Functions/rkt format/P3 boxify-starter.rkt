;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |P3 boxify-starter|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)

;; boxify-starter.rkt

; 
; PROBLEM:
; 
; Use the How to Design Functions (HtDF) recipe to design a function that consumes an image, 
; and appears to put a box around it. Note that you can do this by creating an "outline" 
; rectangle that is bigger than the image, and then using overlay to put it on top of the image. 
; For example:
; 
; (boxify (ellipse 60 30 "solid" "red")) should produce .
; 
; Remember, when we say DESIGN, we mean follow the recipe.
; 
; Leave behind commented out versions of the stub and template.
; 


;;Image -> Image
;;Places box around image input

(check-expect
 (boxify (rectangle 20 40 "solid" "yellow")) ;;input
         (overlay (rectangle 20 40 "outline" "black") (rectangle 20 40 "solid" "yellow")) ;;output
)
(check-expect
 (boxify (ellipse 20 40 "solid" "yellow")) ;;input
         (overlay (rectangle 20 40 "outline" "black") (ellipse 20 40 "solid" "yellow")) ;;output
)

; (define (boxify s) image) ;;stub
; 
; (define (boxify s) ;;template
;   (... s)
; )


(define (boxify s) ;;template
  (overlay (rectangle (image-width s) (image-height s) "outline" "black") s)
)

(boxify (ellipse 20 40 "solid" "purple"))