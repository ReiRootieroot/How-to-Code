;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname |P6 render-bst-w-lines-starter|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;; render-bst-w-lines-starter.rkt

(require 2htdp/image)

; PROBLEM:
; 
; Given the following data definition for a binary search tree,
; design a function that consumes a bst and produces a SIMPLE 
; rendering of that bst including lines between nodes and their 
; subnodes.
; 
; To help you get started, we've added some sketches below of 
; one way you could include lines to a bst.


;; Constants

(define TEXT-SIZE  14)
(define TEXT-COLOR "BLACK")

(define KEY-VAL-SEPARATOR ":")
(define WIDTH 20) ;;added to given list to simplify troubleshooting
(define MTTREE (rectangle WIDTH 1 "solid" "white"))



;; Data definitions:

(define-struct node (key val l r))
;; A BST (Binary Search Tree) is one of:
;;  - false
;;  - (make-node Integer String BST BST)
;; interp. false means no BST, or empty BST
;;         key is the node key
;;         val is the node val
;;         l and r are left and right subtrees
;; INVARIANT: for a given node:
;;     key is > all keys in its l(eft)  child
;;     key is < all keys in its r(ight) child
;;     the same key never appears twice in the tree
; .

(define BST0 false)
(define BST1 (make-node 1 "abc" false false))
(define BST7 (make-node 7 "ruf" false false)) 
(define BST4 (make-node 4 "dcj" false (make-node 7 "ruf" false false)))
(define BST3 (make-node 3 "ilk" BST1 BST4))
(define BST42 
  (make-node 42 "ily"
             (make-node 27 "wit" (make-node 14 "olp" false false) false)
             (make-node 50 "dug" false false)))
(define BST10
  (make-node 10 "why" BST3 BST42))
(define BST100 
  (make-node 100 "large" BST10 false))
#;
(define (fn-for-bst t)
  (cond [(false? t) (...)]
        [else
         (... (node-key t)    ;Integer
              (node-val t)    ;String
              (fn-for-bst (node-l t))
              (fn-for-bst (node-r t)))]))

;; Template rules used:
;;  - one of: 2 cases
;;  - atomic-distinct: false
;;  - compound: (make-node Integer String BST BST)
;;  - self reference: (node-l t) has type BST
;;  - self reference: (node-r t) has type BST

;; Functions:

; 
; Here is a sketch of one way the lines could work. What 
; this sketch does is allows us to see the structure of
; the functions pretty clearly. We'll have one helper for
; the key value image, and one helper to draw the lines.
; Each of those produces a rectangular image of course.
; 
; .
; 
; And here is a sketch of the helper that draws the lines:
; .  
; where lw means width of left subtree image and
;       rw means width of right subtree image


;; BST -> Image
;; interp. generate rendering of BST

;;CONSTANT
(define LW 20)
(define RW 20)

(define (render-bst t)
  (cond [(false? t) MTTREE]
        [else
         (above (text (string-append (number->string (node-key t)) KEY-VAL-SEPARATOR (node-val t)) TEXT-SIZE TEXT-COLOR)    ;String
                (beside
                 (if (false? (node-l t))
                     MTTREE ;;true
                     (add-line MTTREE ;;false
                          LW 0 ;;x1 y1
                          (/ LW 2) (/ (+ LW RW) 4);;x2 y2
                          TEXT-COLOR
                      )
                 )
                 (if (false? (node-r t)) 
                     MTTREE ;;true
                     (add-line MTTREE ;;false
                          LW 0 ;;x1 y1
                          (+ LW (/ RW 2)) (/ (+ LW RW) 4);;x2 y2
                          TEXT-COLOR
                     )
                )
                )
                (beside
                  (render-bst (node-l t))
                  (render-bst (node-r t))
                ) 
          )
        ]
  )
)

(render-bst BST10)