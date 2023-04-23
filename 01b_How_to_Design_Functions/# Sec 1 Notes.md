Here's the text in Markdown format:

## The HtDF Recipe

The HtDF (How to Design Functions) recipe consists of the following steps:

1. **Signature, purpose and stub**

A signature has the type of each argument, separated by spaces, followed by `->`, followed by the type of result. So a function that consumes an image and produces a number would have the signature `Image -> Number`.

The purpose of the stub is to serve as a kind of scaffolding to make it possible to run the examples even before the function design is complete. With the stub in place `check-expects` that call the function can run. Most of them will fail of course, but the fact that they can run at all allows you to ensure that they are at least well-formed: parentheses are balanced, function calls have the proper number of arguments, function and constant names are correct and so on. This is very important, the sooner you find a mistake -- even a simple one -- the easier it is to fix.

```racket
;; Number -> Number
;; produces n times 2
(define (double n)  0)  ; this is the stub
```

2. **Define examples** (wrap each in `check-expect` for Racket)

You will often need more examples, to help you better understand the function or to properly test the function. (If once your function works and you run the program some of the code is highlighted in black it means you definitely do not have enough examples.) If you are unsure how to start writing examples use the combination of the function signature and the data definition(s) to help you generate examples. Often the example data from the data definition is useful, but it does not necessarily cover all the important cases for a particular function.

The first role of an example is to help you understand what the function is supposed to do. If there are boundary conditions be sure to include an example of them. If there are different behaviours the function should have, include an example of each. Since they are examples first, you could write them in this form:

```racket
;; (double 0) should produce 0
;; (double 1) should produce 2
;; (double 2) should produce 4
```

3. **Template and inventory**

Before coding the function body it is helpful to have a clear sense of what the function has to work with -- what is the contents of your bag of parts for coding this function? The template provides this. Once the template is done, the stub should be commented out.

There are no examples. The templates are detailed in each section of the git repo. Please check each section.

*Note: These templates are specific to Racket and this course. These templates could potentially be re-adapted for other languages, as I've found these to be immensely useful.*

4. **Code the function body**

5. **Test and debug until correct**
