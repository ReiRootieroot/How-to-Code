;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname |P5 balance-factor-starter|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;; balance-factor-starter.rkt

; PROBLEM:
; 
; As discussed in lecture, for optimal lookup time we want a BST to be balanced. 
; The oldest approach to this is called AVL self-balancing trees and was invented in 1962. 
; The remainder of this problem set is based on AVL trees.
; 
; An individual node is balanced when the height of its left and right branches differ 
; by no more than 1. A tree is balanced when all its nodes are balanced.
; 
; a) Design the function balance-factor that consumes a node and produces its balance factor,
; which is defined as the height of its left child minus the height of its right child.
; 
; b) Use your function in part a) to design the function balanced?, which consumes a BST and 
; produces true if the tree is balanced.
; 
; Once you have the function, use it to compare what happens with the following two sequences
; of insertions:
; 
; 
; (insert 4 "a" 
;         (insert 5 "a"
;                 (insert 6 "a" 
;                         (insert 7 "a" 
;                                 (insert 8 "a" false)))))
;         
;         
; (insert 4 "a" 
;         (insert 5 "a"
;                 (insert 8 "a" 
;                         (insert 7 "a" 
;                                 (insert 6 "a" false))))) 
; 


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

(define BST0 false)
(define BST1 (make-node 1 "abc" false false))
(define BST4 (make-node 4 "dcj" false (make-node 7 "ruf" false false)))
(define BST3 (make-node 3 "ilk" BST1 BST4))
(define BST42 
  (make-node 42 "ily"
             (make-node 27 "wit" (make-node 14 "olp" false false) false)
             false))
(define BST10 (make-node 10 "why" BST3 BST42))

; .

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

;;=====================================
;;FUNCTIONS

;;PART A solution
;; BST -> Integer
;;produces balance factor of given BST t, subtracting right from left
;;(define (balance-factor t) 0) ;;stub
(check-expect (balance-factor false) 0)
(check-expect (balance-factor BST0) 0)
(check-expect (balance-factor BST4) -1)
(check-expect (balance-factor BST3) -1)
(check-expect (balance-factor BST10) 0)
(check-expect (balance-factor BST42) 2)
(check-expect (balance-factor (make-node 1 "a" (make-node 2 "b"(make-node 3 "c" (make-node 4 "d" false false) false) false) false)) 3)   

(define (balance-factor t)
  (cond [(false? t) 0]
        [else
         (- (count-height (node-l t)) (count-height (node-r t)))
         ]
  )
)

;;BST -> Integer
;;produces height of BST, i.e. rows
;;(define (count-height t) 0) ;;stub
(check-expect (count-height BST0) 0)
(check-expect (count-height BST4) 2)
(check-expect (count-height BST3) 3)
(check-expect (count-height BST10) 4)
(check-expect (count-height BST42) 3)

(define (count-height t)
  (cond [(false? t) 0]
        [else
         (+ 1
              (max
               (count-height (node-l t))
               (count-height (node-r t))
              )
         )
        ]
  )
)

;;PART B solution

;;BST -> Boolean
;;checks if tree is balanced (balance factor within 1), returns true if so
(check-expect (balanced? false) true)
(check-expect (balanced? BST0) true)
(check-expect (balanced? BST4) true)
(check-expect (balanced? BST3) true)
(check-expect (balanced? BST10) true)
(check-expect (balanced? BST42) false)
(check-expect (balanced? (make-node 1 "a" (make-node 2 "b"(make-node 3 "c" (make-node 4 "d" false false) false) false) false)) false)   

;;(define (balanced? t) true) ;;stub
(define (balanced? t)
  (cond [(false? t) true]
        [else
         (determine-balance (- (count-height (node-l t)) (count-height (node-r t))))
        ]
   )
)

;;Integer -> Boolean
;;Broke up into another function to make code more readable
(check-expect (determine-balance 1) true)
(check-expect (determine-balance 0) true)
(check-expect (determine-balance -1) true)
(check-expect (determine-balance 2) false)
(check-expect (determine-balance -2) false)

;;(define (determine-balance i) true) ;;stub
(define (determine-balance i)
  (and (<= i 1) (>= i -1))
)