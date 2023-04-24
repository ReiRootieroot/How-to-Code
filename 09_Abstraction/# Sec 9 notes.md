# Abstraction From Examples
We design abstract functions in the opposite order of the normal HtDF recipe. We always want to do the easiest thing first, and with the abstract function design process, getting the working function definition is the easiest thing to do. In fact, going through the recipe in the opposite order exactly goes from easiest to hardest.

1. Identify two or more fragments of highly repetitive code. In general, these can be expressions that appear within functions, or they can be entire functions. The rest of this recipe is tailored to the case where entire functions have been chosen.
2. Arrange the two functions so that it is easy to see them at the same time.
3. Identify one or more points where the functions differ (points of variance). Do not count differences in function names or parameter names as points of variance.
4. Copy one function definition to make a new one
    * Give the new function a more general name
    * Add a new parameter for each point of variance
    * Update any recursive calls to use the new name and add new parameters in recursive calls
    * Use the appropriate new parameter at each point of variability
    * Rename other parameters to be more abstract (lon to lox, for example)
5. Adapt tests from original functions to the new abstract function
    * Be sure to test variability
    * Attempt to test behavior of the abstract function beyond that exercised by the two examples
6. Develop an appropriately abstract purpose based on the examples.
7. Develop an appropriate signature for the abstract function; in many cases, the signature will include type parameters.
8. Rewrite the body of the two original functions to call the abstract function.

# Abstraction From Type Comments
We design abstract functions in the opposite order of the normal HtDF recipe. We always want to do the easiest thing first, and with the abstract function design process, getting the working function definition is the easiest thing to do. In fact, going through the recipe in the opposite order exactly goes from easiest to hardest.

1. If there are templates for mutually recursive functions, first encapsulate them in a single template with local
2. Replace each ... in the templates with a new parameter; for (...) remove the parens
3. Develop examples (check-expects)
4. Develop an abstract purpose from examples
5. Develop an abstract signature from concrete examples

Let's now go through generating a fold function for (listof X). Here is the type comment for (listof X):

```racket
;; ListOfX is one of:
;; - empty
;; - (cons X ListOfX)
```

We can generate the following template based on this type comment:

```racket
(define (fn-for-lox lox)
  (cond [(empty? lox) (...)]
        [else
         (... (first lox)
              (fn-for-lox (rest lox)))]))
```

Since there is no mutual recursion in the template, we can skip step 1. According to step 2, we need to replace each ... with a new parameter. We also need to rename the function to `fold`. Here is what we would have after step 2:

```racket
(define (fold fn b lox)
  (cond [(empty? lox) b]
        [else
         (fn (first lox)
             (fold fn b (rest lox)))]))
```

Note that we called the ... in place of the base case named `b`, and the ... in place of the function named `fn`.

For step 3, we should write some examples to test for the function and also find out what we can do with the fold function:

```racket
; sum of the numbers in the list
(check-expect (fold + 0 (list 1 2 3)) 6)

; product of the numbers in the list
(check-expect (fold * 1 (list 1 2 3)) 6)

; append the strings in the list
(check-expect (fold string-append "" (list "a" "bc" "def")) "abcdef")

; sum of the areas of the images in the list
(check-expect 
    (local [(define (total-area i a)
        (+ (* (image-width i) (image-height i)) a))]
    
    (fold total-area 0 (list (rectangle 20 40 "solid" "red")                    
                             (right-triangle 10 20 "solid" "red")
                             (circle 20 "solid" "red"))))
    (+ (* 20 40) (* 10 20) (* 40 40)))
```

Step 4 requires us to develop an abstract purpose from the examples. In this example, we can just write:

```racket
;; the abstract fold function for (listof X)
```

In the last step, we need to determine the abstract signature from the examples that we have written. The more diverse the examples that we have, the easier it is to come up with the correct signature.

From the function definition for `fold`, we can reason the following about its signature:
- The parameter `lox` is of type `(listof X)`.
- The parameter `b` is of the same type as what `fold` produces because it is the base case.
- The predicate function `fn` takes in two arguments.
- The predicate function `fn` produces the same type as what `fold` produces.
- The first parameter for the predicate function `fn` is of type `X`.
- The second parameter for the predicate function `fn` is of the same type as what `fold` produces.

From the above reasoning, we can narrow the signature down to:

```racket
(X Y -> Y) Y (listof X) -> Y
```

Note that all of the `???` are of the same type according to the above reasoning. Now the question is whether `???` has to be the same type as `X` or can be something else (i.e., `Y`).

From the fourth example in step 3, we can see that the signature for the predicate function `total-area` is:
```racket
Image Number -> Number
```

In this case, `X` is `Image` and the `???` is `Number`. This is an example of `???` being something different than `X`. Therefore, we can conclude that the abstract signature for `fold` is:

```racket
(X Y -> Y) Y (listof X) -> Y
```

## Using Abstract Functions

The template for using a built-in abstract function like `filter` is:

```racket
;; (listof Number) -> (listof Number)
;; produce only positive? elements of `lon`

;; tests elided

;; template as call to abstract function
(define (only-positive lon)
  (filter ... lon))
```

Now we note that the type of `lon` is `(listof Number)`, and the signature of `filter` is `(X -> Boolean) (listof X) -> (listof X)`. This means that the signature of the function passed to `filter` is `(Number -> Boolean)`. So we can further decorate the template as follows:

```racket
(define (only-positive lon)
  ;(Number -> Boolean)
  (filter ... lon))
```

This serves as a note to ourselves about the signature of the function we replace `...` with.