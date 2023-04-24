# Generative Recursion

The template for generative recursion is:

```
(define (genrec-fn d)
  (cond [(trivial? d) (trivial-answer d)]
        [else
         (... d 
              (genrec-fn (next-problem d)))]))
```

In this template, `d` represents the data that the function is operating on. The `trivial?` function determines if the problem is simple enough to solve without further recursion, and the `trivial-answer` function produces the answer to the trivial problem.

If the problem is not trivial, then the function proceeds to solve the problem by recursively calling itself with the next problem obtained by applying the `next-problem` function to the original data `d`. The `...` represents the code that solves the problem for the current data `d`.

Generative recursion is useful for problems where the data can be broken down into simpler subproblems. By breaking down the problem into simpler subproblems and solving them recursively, the function can solve the original problem.