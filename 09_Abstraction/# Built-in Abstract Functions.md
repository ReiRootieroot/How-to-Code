# Built-In Abstract Functions

ISL and ASL have the following built-in abstract functions:

```scheme
(@signature Natural (Natural -> X) -> (listof X))
;; produces (list (f 0) ... (f (- n 1)))
(define (build-list n f) ...)

(@signature (X -> boolean) (listof X) -> (listof X))
;; produce a list from all those items on lox for which p holds
(define (filter p lox) ...)

(@signature (X -> Y) (listof X) -> (listof Y))
;; produce a list by applying f to each item on lox
;; that is, (map f (list x-1 ... x-n)) = (list (f x-1) ... (f x-n))
(define (map f lox) ...)

(@signature (X -> boolean) (listof X) -> Boolean)
;; produce true if p produces true for every element of lox
(define (andmap p lox) ...)

(@signature (X -> boolean) (listof X) -> Boolean)
;; produce true if p produces true for some element of lox
(define (ormap p lox) ...)

(@signature (X Y -> Y) Y (listof X) -> Y)
;; (foldr f base (list x-1 ... x-n)) = (f x-1 ... (f x-n base))
(define (foldr f base lox) ...)

(@signature (X Y -> Y) Y (listof X) -> Y)
;; (foldl f base (list x-1 ... x-n)) = (f x-n ... (f x-1 base))
(define (foldl f base lox) ...)
```
------------------------------
The "lambda" function can be  used to shorthand the built-in functions into one line without needing to define variables and functions across multiple lines. The function is read as seen below as per Racket documentation:

```scheme
(lambda (variable variable ...) expression_with_variable)

;; Creates a function that takes as many arguments as given variables, and whose body is expression.
```

Essentially, "lambda" allows to be as any parameters to be passed and processed without defining said parameter. Notice that parameters that could be passed also includes functions- this means that *functions do not need to be defined before passing*. Optimizing code and overall formatting is siginificantly easier with the use of "lambda" function, especially functions are used within the scope of another function only and do not need to be defined globally despite being used once.

To quickly read the syntax, just understand that "define" and the function name is replaced with "lambda". The function being defined with lambda *is nameless*.

As an example, these two codes perform the same function:

```scheme
;;lon is a list of numbers
;;THRESHOLD is a constant
;;          defined as boundary to exceed

(define (only-bigger-define THRESHOLD lon)
  (local [(define (pred n) 
            (> n THRESHOLD))]    
    (filter pred lon)))

(define (only-bigger-lambda THRESHOLD lon)
  (filter (lambda (n) (> n THRESHOLD)) lon)
)
```
Inside the "only-bigger-lambda" function, nothing has changed in the parameters passed to the "filter" function. The "pred" function is still used as the condition to meet to be included in the filtered list.

In the context of using the built-in functions, the lambda is best formatted as such, using the above example:
```scheme
(lambda (n) (> n THRESHOLD))
(lambda (element-of-list) (boolean-function element-of-list))
```
Note the "boolean-function" isn't restricted to only the element. If you need to, include any other parameters into "boolean-function".