;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname |L4 render-bst-starter|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)

;; render-bst-starter.rkt

; 
; Consider the following data definition for a binary search tree: 
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
; .

(define BST0 false)
(define BST1 (make-node 1 "abc" false false))
(define BST4 (make-node 4 "dcj" false (make-node 7 "ruf" false false)))
(define BST3 (make-node 3 "ilk" BST1 BST4))
(define BST42 
  (make-node 42 "ily"
             (make-node 27 "wit" (make-node 14 "olp" false false) false)
             (make-node 50 "dug" false false)))
(define BST10
  (make-node 10 "why" BST3 BST42))
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


; PROBLEM:
; 
; Design a function that consumes a bst and produces a SIMPLE 
; rendering of that bst. Emphasis on SIMPLE. You might want to 
; skip the lines for example.
; 


;;Begin program with (render-bst t) in terminal, where t is one of the Binary Search Trees defined as constants above

;;CONSTANTS
(define TEXT-SIZE 14)
(define TEXT-COLOR "black")
(define KEY-VAL-SEPARATOR ":")
(define VSPACE (rectangle 1 10 "solid" "white")) ;;vertical space
(define HSPACE (rectangle 10 1 "solid" "white")) ;;horizontal space
(define MTTREE (rectangle 20 10 "solid" "white")) ;;horizontal space

;; BST -> Image
;; interp. generate rendering of BST
(define (render-bst t)
  (cond [(false? t) MTTREE]
        [else
         (above (text (string-append (number->string (node-key t)) KEY-VAL-SEPARATOR (node-val t)) TEXT-SIZE TEXT-COLOR)    ;String
                VSPACE
                (beside
                  (render-bst (node-l t))
                  HSPACE
                  (render-bst (node-r t))
                ) 
          )
        ]
  )
)
