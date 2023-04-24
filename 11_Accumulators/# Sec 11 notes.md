# Accumulators

There are three general ways to use an accumulator in a recursive function (or set of mutually recursive functions):

1. To preserve context otherwise lost in structural recursion.
2. To make a function tail recursive by preserving a representation of the work done so far (aka a result-so-far accumulator).
3. To make a function tail recursive by preserving a representation of the work remaining to do (aka a worklist accumulator).

The same basic recipe covers all three forms of accumulators. The main example shown here is a context preserving accumulator.

## The basic recipe and context preserving accumulators.

Signature, purpose, stub and examples

Design of the function begins normally, with signature, purpose, stub, and examples.

```scheme
;; (listof X) -> (listof X)
;; produce list formed by keeping the 1st, 3rd, 5th and so on elements of lox
(check-expect (skip1 (list "a" "b" "c" "d")) (list "a" "c"))
(check-expect (skip1 (list 0 1 2 3 4)) (list 0 2 4))

(define (skip1 lox) empty) ;stub
```

## Templating

The template step is a 3-part process. The first step is to template normally according to the rules for structural recursion, i.e., template according to the `(listof X)` parameter.

```scheme
(define (skip1 lox)
  (cond [(empty? lox) (...)]
        [else
         (... (first lox)
              (skip1 (rest lox)))]))
```

The next step is to encapsulate that function in an outer function and local. As part of this step give the outer function parameter a different name than the inner function parameter. Note that if you are working with multiple mutually recursive functions, they call get wrapped in a single outer function.

```scheme
(define (skip1 lox0)
  (local [(define (skip1 lox)
            (cond [(empty? lox) (...)]
                  [else
                   (... (first lox)
                        (skip1 (rest lox)))]))]

    (skip1 lox0)))
```

Now add the accumulator parameter to the inner function. In addition, add `...` or more substantial template expressions in each place that calls the inner function. During this step, treat the accumulator parameter as atomic.

```scheme
(define (skip1 lox0)
  (local [(define (skip1 lox acc)
            (cond [(empty? lox) (... acc)]
                  [else
                   (... acc
                        (first lox)
                        (skip1 (rest lox)
                               (... acc (first lox))))]))]

    (skip1 lox0 ...)))
```

## Accumulator type, invariant, and examples

The next step is to work out what information the accumulator will represent and how it will do that. Will the accumulator serve to represent some context that would otherwise be lost to structural recursion? Or, to support tail recursion, will it represent some form of result so far? Or will it represent a work list of some sort? In many cases, this is clear before reaching this stage of the design process. In other cases, examples can be used to work this out. But in all cases, examples are useful to work out exactly how the accumulator will represent the information.

In this case, we need to know, in each recursive call to the inner function, whether the current first item in the list should be kept or skipped. There are many ways to represent this, but one simple way is to use a natural that represents how far into the original list (lox0) we have traveled. If we assume the call to the top-level definition of `skip1` is `(skip1 (list 0 1 2 3 4))`, then the progression of calls to the internal `skip1` would be as follows:

```
(skip1 (list 0 1 2 3 4) 1)       ; the 0 is the 1st element of lox0 (using 1 based indexing)
(skip1 (list   1 2 3 4) 2)       ; the 1 is the 2nd element
(skip1 (list     2 3 4) 3)       ; the 2 is the 3rd 
(skip1 (list       3 4) 4)       ; the 3 is the 4th
(skip1 (list         4) 5)       ; the 4 is the 5th
(skip1 (list          ) 6)
```

Note that the accumulator value is not constant, but it always represents the position of the current (first lox) in the original list lox0. (You can see here why we renamed the parameter to the outer function; it makes it easier to describe the relation between the original value `lox0` and the value in each recursive call `lox`.)

These examples of the progression of calls to the internal recursive function(s) allow us to work out clearly the accumulator type, as well as its invariant, which describes what is constant about the accumulator as it changes -- in other words, what property it always represents. In this case, the type is `Natural`, and the invariant is the 1-based index of `(first lox)` in `lox0`. So when the accumulator is an odd number, we will keep `(first lox)` in the result, when it is even, we will skip `(first lox)`.

```scheme
(define (skip2 lox0)
  ;; acc is Natural; how many elements of lox to keep before next skip
  ;; (skip2 (list 0 1 2 3 4) 1)
  ;; (skip2 (list   1 2 3 4) 0)
  ;; (skip2 (list     2 3 4) 1)
  ;; (skip2 (list       3 4) 0)
  ;; (skip2 (list         4) 1)
  ;; (skip2 (list          ) 
  (local [(define (skip2 lox acc)
            (cond [(empty? lox) (... acc)]
                  [else
                   (... acc
                        (first lox)
                        (skip2 (rest lox)
                               (... acc (first lox))))]))
```
## Tail Recursion
To make the function tail recursive, all recursive calls must be in tail position. For functions that operate on flat structures (data that has only one reference cycle), this can be accomplished by using an accumulator to represent build up information about the final result through the series of recursive calls.  We often name these accumulators rsf but it is worth noting that some functions require more than one result so far accumulator (see average).

Making functions that operate on data with more than one cycle in the graph (such as arbitrary-arity trees) usually requires the use of an accumulator to build up the data that still remains to be operated on. This is a worklist accumulator, often called todo.
