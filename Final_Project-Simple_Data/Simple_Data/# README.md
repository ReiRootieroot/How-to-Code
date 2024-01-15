## Space Invader (Space Invaders)

The Space Invaders program is a game where a tank will shoot at randomly generated invaders. The player can control the tank by inputting directions and firing missiles to prevent invaders from reaching the bottom of the screen.

The purpose of this project was to demonstrate my understanding of concepts taught in the How to Code: Simple Data course presented by [UBCx's MicroMasters Program in Software Development](https://www.edx.org/micromasters/ubcx-software-development) (University of British Columbia) on [EdX](https://www.edx.org/). The program was created within the concepts taught below:

- How to represent information as data
- How to focus each part of your program on a single task
- How to use examples and tests to clarify what your program should do
- How to simplify the structure of your program using common patterns
- Recognize and represent more complicated information

## Table of contents

- Controls
- Installation & Running Program
- Configuration
- Future Potential Updates


## Controls
Tank will move continuously in the direction of your input.

To move left, press left arrow.

To move right, press right arrow.

To fire a missile, press spacebar.

To restart a game, press enter.

## Installation & Running Program
The program will run only in Racket. To download the necessary IDE, please follow instructions at [Racket's website](https://racket-lang.org/).

Once installed, please download "Simple_Data_space-invaders-starter.rkt" and run the program to compile.

The program will start with the command
```
(main 0)
```

## Configuration

The program cannot be configured externally. All changes must take place within the program. Please run the program after each change to ensure the program was updated correctly.

* To adjust tank speed, change the value of TANK-SPEED.
* To adjust invader speed, change the values of INVADER-X-SPEED and INVADER-Y-SPEED.
* To adjust the rate of invaders appearing, change the value of INVADER-RATE.

## Future Potential Updates

* Add a game randomizer when program is initialized each time
    * The game starts in the same configuration every time the program is started. I ran out of time in being able to add this feature. This would require balancing and testing to ensure the randomizer function would not place invaders in unfair positions.
* Create a new function for creating a Game datatype.
    * The language for creating is quite long and arduous for one to understand concisely. In an effort to make the code a little more readable and modular, a function for creating a Game datatype would be helpful. Furthermore, the new function would allow for different configurations of a Game datatype, such as the randomized Game mentioned above.
* Fold "increment-invaders", "increment-missiles", and "increment-tank" into a singular function.
    * Calling all those functions add to somewhat difficult readability of the code. Like above, folding into one singular "increment" function would provide more concise code.
* Rewrite "remove-list" function to be more modular.
    * As of now, the function takes in an invader datatype as an argument and removes missiles on whether it matches the invader coordinates. This would be a rather unnecessary narrow scope while originally writing this program. While this code does not require any specific list removal, the code can be re-written to reflect a "remove-list" function change to be more modular and also eventually set up for better optimization.
* Add introduction screen when starting game.
    * There is no text to help educate players about controls. Furthermore, the game begins automatically whether players are ready or not. Coding an intro screen into the game would be helpful and make the game look more professional.
* Create Binary Search Tree search algorithm.
    * This was meant to be further proof of learning the concept as detailed above. Because of time, I had to give up on this.