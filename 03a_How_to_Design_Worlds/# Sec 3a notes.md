# How to Design Worlds Process

The **How to Design Worlds** process provides guidance for designing interactive world programs using `big-bang`. While some elements of the process are tailored to `big-bang`, the process can also be adapted to the design of other interactive programs. The wish-list technique can be used in any multi-function program.

World program design is divided into two phases, each of which has sub-parts:

1. **Domain analysis** (use a piece of paper!)
   - Sketch program scenarios
   - Identify constant information
   - Identify changing information
   - Identify `big-bang` options
2. **Build the actual program**
   - Constants (based on 1.2 above)
   - Data definitions using `HtDD` (based on 1.3 above)
   - Functions using `HtDF`
     - `main` first (based on 1.3, 1.4 and 2.2 above)
     - wish list entries for `big-bang` handlers
   - Work through wish list until done

Identify which `big-bang` options the program needs.

If your program needs to: | Then it needs this option:
--- | ---
change as time goes by (nearly all do) | `on-tick`
display something (nearly all do) | `to-draw`
change in response to key presses | `on-key`
change in response to mouse activity | `on-mouse`
stop automatically | `stop-when`

```racket
(define (handle-key ws ke)
  (cond [(key=? ke " ") (... ws)]
        [else 
         (... ws)]))

(define (handle-mouse ws x y me)
  (cond [(mouse=? me "button-down") (... ws x y)]
        [else
         (... ws x y)]))
```

Example code:

```racket
(require 2htdp/image)
(require 2htdp/universe)

;; My world program  (make this more specific)

;; =================
;; Constants:


;; =================
;; Data definitions:

;; WS is ... (give WS a better name)



;; =================
;; Functions:

;; WS -> WS
;; start the world with ...
;; 
(define (main ws)
  (big-bang ws                   ; WS
            (on-tick   tock)     ; WS -> WS
            (to-draw   render)   ; WS -> Image
            (stop-when ...)      ; WS -> Boolean
            (on-mouse  ...)      ; WS Integer Integer MouseEvent -> WS
            (on-key    ...)))    ; WS KeyEvent -> WS

;; WS -> WS
;; produce the next ...
;; !!!
(define (tock ws) ...)


;; WS -> Image
;; render ... 
;; !!!
(define (render ws) ...)
```

Depending on which other `big-bang` options you are using you would also end up with wish list entries for those handlers. So, at an early stage a world program might look like this:

```racket
(require 2htdp/universe)
(require 2htdp/image)

;; A cat that walks across the screen.

;; Constants:

(define WIDTH  200)
(define HEIGHT 200)

(define CAT-IMG (circle 10 "solid" "red")) ; a not very attractive cat

(define MTS (empty-scene WIDTH HEIGHT))


;; Data definitions:

;; Cat is Number
;; interp. x coordinate of cat (in screen coordinates)
(define C1 1)
(define C2 30)

#;
(define (fn-for-cat c)
  (... c))


;; Functions:

;; Cat -> Cat
;; start the world with initial state c, for example: (main