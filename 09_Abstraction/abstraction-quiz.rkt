;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname abstraction-quiz) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
;  PROBLEM 1:
;  
;  Design an abstract function called arrange-all to simplify the 
;  above-all and beside-all functions defined below. Rewrite above-all and
;  beside-all using your abstract function.


;; ABSTRACT FUNCTION WORK
;; -------------------------------------------
(define (arrange-all fn base loi)
  (cond [(empty? loi) base]
        [else
         (fn (first loi)
                 (arrange-all fn base (rest loi)))]))

;; (listof Image) -> Image
;; combines a list of images into a single image, each image above the next one
(check-expect (above-all empty) empty-image)
(check-expect (above-all (list (rectangle 20 40 "solid" "red") (star 30 "solid" "yellow")))
              (above (rectangle 20 40 "solid" "red") (star 30 "solid" "yellow")))
(check-expect (above-all (list (circle 30 "outline" "black") (circle 50 "outline" "black") (circle 70 "outline" "black")))
              (above (circle 30 "outline" "black") (circle 50 "outline" "black") (circle 70 "outline" "black")))

;(define (above-all loi) empty-image)  ;stub

; (define (above-all loi)
;   (cond [(empty? loi) empty-image]
;         [else
;          (above (first loi)
;                 (above-all (rest loi)))]))


(define (above-all loi)
  (local [(define fn above)
          (define base empty-image)
         ]
    (arrange-all fn base loi)
  )
)

;; (listof Image) -> Image
;; combines a list of images into a single image, each image beside the next one
(check-expect (beside-all empty) (rectangle 0 0 "solid" "white"))
(check-expect (beside-all (list (rectangle 50 40 "solid" "blue") (triangle 30 "solid" "pink")))
              (beside (rectangle 50 40 "solid" "blue") (triangle 30 "solid" "pink")))
(check-expect (beside-all (list (circle 10 "outline" "red") (circle 20 "outline" "blue") (circle 10 "outline" "yellow")))
              (beside (circle 10 "outline" "red") (circle 20 "outline" "blue") (circle 10 "outline" "yellow")))

;(define (beside-all loi) empty-image)  ;stub

; (define (beside-all loi)
;   (cond [(empty? loi) (rectangle 0 0 "solid" "white")]
;         [else
;          (beside (first loi)
;                  (beside-all (rest loi)))]))


(define (beside-all loi)
  (local [(define fn beside)
          (define base (rectangle 0 0 "solid" "white"))
         ]
    (arrange-all fn base loi)
  )
)


;  PROBLEM 2:
;  
;  Finish the design of the following functions, using built-in abstract functions. 
;  


;; Function 1
;; ==========

;; (listof String) -> (listof Natural)
;; produces a list of the lengths of each string in los
(check-expect (lengths empty) empty)
(check-expect (lengths (list "apple" "banana" "pear")) (list 5 6 4))
;; (define (lengths lst) empty)

(define (lengths lst)
  (map string-length lst)
)

;; Function 2
;; ==========

;; (listof Natural) -> (listof Natural)
;; produces a list of just the odd elements of lon
(check-expect (odd-only empty) empty)
(check-expect (odd-only (list 1 2 3 4 5)) (list 1 3 5))
;; (define (odd-only lon) empty)

(define (odd-only lon)
  (filter odd? lon)
)



;; Function 3
;; ==========

;; (listof Natural -> Boolean
;; produce true if all elements of the list are odd
(check-expect (all-odd? empty) true)
(check-expect (all-odd? (list 1 2 3 4 5)) false)
(check-expect (all-odd? (list 5 5 79 13)) true)
;; (define (all-odd? lon) empty)

(define (all-odd? lon)
  (andmap odd? lon)
)



;; Function 4
;; ==========

;; (listof Natural) -> (listof Natural)
;; subtracts n from each element of the list
(check-expect (minus-n empty 5) empty)
(check-expect (minus-n (list 4 5 6) 1) (list 3 4 5))
(check-expect (minus-n (list 10 5 7) 4) (list 6 1 3))
;; (define (minus-n lon n) empty)

(define (minus-n lon n)
   (local [(define (subt t) (- t n))]
     (map subt lon)
   )
)

;  PROBLEM 3
;  
;  Consider the data definition below for Region. Design an abstract fold function for region, 
;  and then use it do design a function that produces a list of all the names of all the 
;  regions in that region.
;  
;  For consistency when answering the multiple choice questions, please order the arguments in your
;  fold function with combination functions first, then bases, then region. Please number the bases 
;  and combination functions in order of where they appear in the function.
;  
;  So (all-regions CANADA) would produce 
;  (list "Canada" "British Columbia" "Vancouver" "Victoria" "Alberta" "Calgary" "Edmonton")


(define-struct region (name type subregions))
;; Region is (make-region String Type (listof Region))
;; interp. a geographical region

;; Type is one of:
;; - "Continent"
;; - "Country"
;; - "Province"
;; - "State"
;; - "City"
;; interp. categories of geographical regions

(define VANCOUVER (make-region "Vancouver" "City" empty))
(define VICTORIA (make-region "Victoria" "City" empty))
(define BC (make-region "British Columbia" "Province" (list VANCOUVER VICTORIA)))
(define CALGARY (make-region "Calgary" "City" empty))
(define EDMONTON (make-region "Edmonton" "City" empty))
(define ALBERTA (make-region "Alberta" "Province" (list CALGARY EDMONTON)))
(define CANADA (make-region "Canada" "Country" (list BC ALBERTA)))

; 
; (define (fn-for-region r)
;   (local [(define (fn-for-region r)
;             (... (region-name r)
;                  (fn-for-type (region-type r))
;                  (fn-for-lor (region-subregions r))))
;           
;           (define (fn-for-type t)
;             (cond [(string=? t "Continent") (...)]
;                   [(string=? t "Country") (...)]
;                   [(string=? t "Province") (...)]
;                   [(string=? t "State") (...)]
;                   [(string=? t "City") (...)]))
;           
;           (define (fn-for-lor lor)
;             (cond [(empty? lor) (...)]
;                   [else 
;                    (... (fn-for-region (first lor))
;                         (fn-for-lor (rest lor)))]))]
;     (fn-for-region r)))
; 


; ;; (String Y Z -> A)
; Pass function for processing region name, type, and (listof Region)
; 
; ;; [B x5]
; Initialized value for each of the enumerations
; 
; ;; C
; Initialized value for ;; (Y Z -> A)
; 
; ;; (Y Z -> A)
; Pass function for processing Region
; Since this is coming from the (listof Region) passed into the function, by nature (listof Region) is also processed


;;(String String Z -> A) [B x5] C (Y Z -> A) Region -> A
(define (fold-region a1 b1 b2 b3 b4 b5 c1 d1 r)
  (local [(define (fn-for-region r)                      ; Region -> A
            (a1 (region-name r)
                (fn-for-type (region-type r))
                (fn-for-lor (region-subregions r))))
          
          (define (fn-for-type t)                        ; Enum -> B
            (cond [(string=? t "Continent") b1]
                  [(string=? t "Country") b2]
                  [(string=? t "Province") b3]
                  [(string=? t "State") b4]
                  [(string=? t "City") b5]))
          
          (define (fn-for-lor lor)                       ; (listof Region) -> A
            (cond [(empty? lor) c1]
                  [else 
                   (d1 (fn-for-region (first lor))
                       (fn-for-lor (rest lor)))]))]
    (fn-for-region r)))

;; Region -> (listof name)
;; produce list of all names in a given region in descending-type order,
;; in such that once a descendant order is complete, the function will return to the next smallest type size available
;; and begin printing SAID next smallest type's region names in descending-type order
;; i.e. list "Continent" name -> "Country" name -> "Province" name -> .... -> return to new "Country" name -> "Province" name (of new "Country) -> etc. 
;; (define (all-region-names r) empty) ;;stub
(check-expect (all-region-names VANCOUVER) (list "Vancouver"))
(check-expect (all-region-names BC) (list "British Columbia" "Vancouver" "Victoria"))
(check-expect (all-region-names CANADA) (list "Canada" "British Columbia" "Vancouver" "Victoria" "Alberta" "Calgary" "Edmonton"))

(define (all-region-names r)
  (local [(define (a1 reg t lor) (cons reg (if (false? t)
                                               lor
                                               empty
                                               ))
          )
          (define b1 false)
          (define b2 false)
          (define b3 false)
          (define b4 false)
          (define b5 true)
          (define c1 empty)
          (define (d1 reg2 lor2) (append reg2 lor2))
         ]
    (fold-region a1 b1 b2 b3 b4 b5 c1 d1 r)
  )
)




                   
