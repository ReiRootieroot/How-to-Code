## Shared Expression Evaluation

The evaluation of `shared` is truly one of the deep mysteries of the universe. There are two very different ways to describe the evaluation rules.

One cannot be described exactly in terms of BSL (or ISL), but informally goes as follows:

1. Each of the variables is defined as a constant with a special unique dummy value.
2. Then the expressions are evaluated.
3. Then each of the constants has its value change to the corresponding value. This is the part we have no words for in BSL or ISL, it is called mutation.
4. Finally, each of those values is traversed, and each time one of the dummy values appears, it is replaced in-situ by the corresponding value. (A different form of mutation.)

This evaluation rule for `shared` is cumbersome but goes beyond what we know.

For further reading, please refer to "The Why of Y" at https://www.dreamsongs.com/Files/WhyOfY.pdf.

-----

An example is given below:
```racket
(define-struct room (name exits))
;; Room is (make-room String (listof Room))
;; interp. the room's name, and list of rooms that the exits lead to

(define H3
  (shared ((-A- (make-room "A" (list -B-)))
           (-B- (make-room "B" (list -C-)))
           (-C- (make-room "C" (list -A-))))
    -A-))
```

Think all of the rooms A, B, and C as being connected by doorways. If B were connected to room A only (assuming room C doesn't exist), then the code will look something like this:

```racket
(define H3
  ((make-room "A" (list 
                    (make-room "B" (list 
                        (make-room "A" (list 
                            (make-room "B" (list ....)))))))))
)
```
The exits in the list would need to constantly refer its exact phrasing ```(make-room "A" list(make-room "B" (list ...)))``` over and over again, which isn't possible with this syntax. As such, the syntax given to solve that issue in Racket is ```shared```.

Taking the example above and steps from our POV, what happens is Racket recognizes that the code must stop reading the next immediate character and begin reading where the designated marker exists.

### *Code 1*
```
(define H3
  (shared ((-A- (make-room "A" (list -B-
```
Racket reads that ```-B-``` indicates a shared statement, so it will immediately begin searching for where ```-B-``` was declared within the shared statement.

### *Code 2*
```
(-B- (make-room "B" (list -C-)))
```
The same goes for ```-C-```.

### *Code 3*
```
(-C- (make-room "B" (list -A-)))
```
...which loops back to room A in *Code 1*.
