# Template Blending

To understand template blending, it is important to understand that templates are what we know about the core of a function (or set of functions) before we get to the details. Data-driven (or structural recursion) templates are that, backtracking templates are that, and generative recursion templates are that.

In some cases, we know more than one thing about the core structure of a function (or set of functions). In the Sudoku solver, for example, three different templates apply to the solve function:

1. Arbitrary-arity tree - We consider each board to have a set of next boards formed by filling the first empty cell with the numbers from 1 - 9. So this forms an arbitrary-arity tree (the arity is actually [0, 9]).
2. Generative recursion - While each board has a set of next boards, that set is included in the representation of the board. Instead, those next boards have to be generated. So we have a generated arbitrary-arity tree.
3. Backtracking search - In addition, we need to do a backtracking search over the arbitrary-arity tree.

In template blending, we take multiple templates that contribute to the structure of a function (or functions) and combine them together.

We have the following for the `solve` function:

```scheme
;; Board -> Board or false

;; produce a solution for bd; or false if bd is unsolvable

;; Assume: bd is valid

(check-expect (solve BD4) BD4s)

(check-expect (solve BD5) BD5s)

(check-expect (solve BD7) false)



(define (solve bd) false) ;stub
```

Now let's start with the template for arbitrary-arity tree. Remember that the template for an arbitrary-arity tree involves mutual recursion. In this case, we would have a function that consumes Board (i.e., `solve--bd`) and calls another function (i.e., `solve--lobd`) that does something to the `(listof Board)` that is supposed to come with the Board (a Board doesn't actually come with a `(listof Board)`, but we will deal with it using generative recursion later). In order to complete the mutual recursion, we need to call `solve--bd` inside the function `solve--lobd`. So now we have the following template:

```scheme
(define (solve bd)
  (local [(define (solve--bd bd)
            (... (solve--lobd (bd-subs bd))))
          (define (solve--lobd lobd)
            (cond [(empty? lobd) (...)]
                  [else
                   (... (solve--bd (first lobd))
                        (solve--lobd (rest lobd)))]))]
    (solve--bd bd)))
```

Keep in mind that the `bd-subs` selector doesn't exist because Board does not keep a `(listof Board)`. We need to deal with it using generative recursion.

Let's blend this template with the generative recursion template. The generative recursion template looks like this:

```scheme
(define (genrec-fn d)
  (if (trivial? d)
      (trivial-answer d)
      (... d
           (genrec-fn (next-problem d)))))
```

Since we know that `solve--bd` must generate a `(listof Board)` to pass to `solve--lobd`, we must blend the template into the `solve--bd` function. Then we would have:

```scheme
(define (solve bd)
  (local [(define (solve--bd bd)
            (if (solved? bd) ;;GENERATIVE RECURSION
                bd           ;;
                (solve--lobd (next-boards bd)))) ;;
          (define (solve--lobd lobd)
            (cond [(empty? lobd) (...)]
                  [else
                   (... (solve--bd (first lobd))
                        (solve--lobd (rest lobd)))]))]
    (solve--bd bd)))
```

Notice the following:

- `bd-subs` is changed to `next-boards` because it suggests that we are generating new boards.
- `trivial?` from the generative recursion template is changed to `solved?` because the trivial case (i.e., the case where the recursion should stop at) is when the board is solved.
- `trivial-answer` from the generative recursion template is omitted because, in this case, the trivial answer is the board that is solved, which is represented by `bd`.

Lastly, we need to blend in the template for backtracking search. The template is:

```scheme
(define (backtracking-fn x)
  (local [(define (fn-for-x x)
            (... (fn-for-lox (x-subs x))))
          (define (fn-for-lox lox)
            (cond [(empty? lox) false]
                  [else
                   (local [(define try (fn-for-x (first lox)))] ;try first child
                     (if (not (false? try))                     ;successful?
                         try                                    ;if so produce that
                         (fn-for-lox (rest lox))))]))]          ;or try rest of children
    (fn-for-x x)))
```

We need to blend the template for `fn-for-lox` from above into the function `solve--lobd`. The changes are marked with *:

```scheme
(define (solve bd)
  (local [(define (*solve--bd* bd)
            (if (solved? bd)
                bd
                (*solve--lobd* (next-boards bd))))
          (define (*solve--lobd* lobd)
            (cond [(empty? lobd) false]
                  [else
                   (local [(define try (solve--bd (first lobd)))]

                        (if (not (false? try))
                            try
                            (*solve--lobd* (rest lobd))))]))]
    (solve--bd bd)))
```

The template allows the `solve--lobd` function to do the following:

- If we have reached the end of the `(listof Board)` (i.e., if `lobd` is empty - the base case), then produce `false`, meaning that the `(listof Board)` has no solution.
- If the `(listof Board)` is not empty, then try to solve the first board in the list (i.e., `(solve--bd (first lobd))`).
- If the outcome of the `try` is not `false` (i.e., `(not (false? try))`), then produce that outcome because it means the board has been solved.
- If the outcome is `false`, then recurse and try the rest of the list (i.e., `(solve--lobd (rest lobd))`).

Now we have the complete template below. Using the arbitrary-arity tree template as the base, the generative recursion template and the backtracking search template is in green:

```scheme
(define (solve bd)
  (local [(define (solve--bd bd)
            (if (solved? bd) ;;GENERATIVE RECURSION
                bd
                (solve--lobd (next-boards bd))))
          (define (solve--lobd lobd)
            (cond [(empty? lobd) false]
                  [else
                   (local [(define try (solve--bd (first lobd)))] ;;BACKTRACKING SEARCH
                        (if (not (false? try))          ;;
                            try                         ;;
                            (solve--lobd (rest lobd)))  ;;
                   )]))]
    (solve--bd bd)))
```


               