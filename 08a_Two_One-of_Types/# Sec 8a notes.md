# Producing the Template for an Example One Of Type

In many cases, more than one of the above rules will apply to a single template. Consider this type comment:

```racket
;; Clock is one of:
;; - Natural
;; - false
```

and the step-by-step construction of the template for a function operating on `Clock`.

`Clock` is a one of type with two subclasses (one of which is not distinct making it an itemization). The `one of` rule tells us to use a `cond`. The `cond` needs one clause for each subclass of the itemization.

```racket
(define (fn-for-clock c)
  (cond [Q A]
        [Q A]))

**Template rules used:**
- one of: 2 cases
```

The `cond` questions need to identify each subclass of data. The `cond` answers need to follow templating rules for that subclass's data. In the first subclass, `Natural` is a non-distinct type; the `atomic non-distinct` rule tells us the question and answer as shown to the left.

```racket
(define (fn-for-clock c)
  (cond [(number? c) (... c)]
        [Q A]))

**Template rules used:**
- one of: 2 cases
- atomic non-distinct: Natural
```



In the second case, `false` is an atomic distinct type, so the `atomic-distinct` rule gives us the question and answer. Since the second case is also the last case we can use `else` for the question.

```racket
(define (fn-for-clock c)
  (cond [(number? c) (... c)]
        [else
         (...)]))

**Template rules used:**
- one of: 2 cases
- atomic non-distinct: Natural
- atomic distinct: false
```

