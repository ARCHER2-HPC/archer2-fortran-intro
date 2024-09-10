# Mini-exercise: Solve a tri-diagonal system

## Exercise (20 minutes)

This exercise will solve a tri-diagonal system of equations as described
here: https://en.wikipedia.org/wiki/Tridiagonal_matrix_algorithm

The accompanying template `exercise.f90` has some further instructions,
and some suggestions on how to test the result.

A solution to the problem appears as a template to the exercise in
[section3.03](../section3.03/exercise.f90).


## Alternative Exercise (20 minutes)

In this exercise you will create a simple implementation of 
[Conway's Game of Life](https://en.wikipedia.org/wiki/Conway%27s_Game_of_Life). 
Game of Life is a _cellular automata_ model where an array of cells is updated
based on simple [rules](https://en.wikipedia.org/wiki/Conway%27s_Game_of_Life#Rules) 
about the values of each neighbouring cell. 

Using the [rules described here](https://en.wikipedia.org/wiki/Conway%27s_Game_of_Life#Rules) (also summarised below), create an array with an initial starting pattern, then
write code to advance the initial pattern to the next iteration based on the rules above.

To get an idea for what you need to implement, experiment using this online version of
the game: https://playgameoflife.com/

### Hints

1. You only need a small `NxN` array to begin with, intialised with a simple pattern of 
 1's (live cells) and 0's (dead cells). You could design the starting pattern
 with the help of the online tool above to visulise it.

1. Your program might use the following steps:

   - Initialise a starting array with a basic pattern
   - Iterate over the array and inspect the neighbouring 8 cells, 
   determining the number of live neighbours.
   - Update the current cell based on the [Rules](https://en.wikipedia.org/wiki/Conway%27s_Game_of_Life#Rules).
   - Once complete, print out the initial state of the board, then the next iteration.

1. If you complete the above, extend the implementation so that it iterates through multiple 
timesteps.

1. Consider how you might handle updating cells at the edges of your array (bounds checking)

A initial solution that prints the inital state and first iteration is provided in the relevant subfolder in the [solutions](../solutions/section2.04-1/solution_gameoflife.f90) folder.

### Game of Life Rules

The Game of Life rules are summarised below:

| Cell state   | Sum of neighbouring 8 cells     | New Cell state |
| ------------ | ------------------------------- | -------------- |
| 1            | 0,1                             | 0              |
| 1            | 4,5,6,7,8                       | 0              |
| 1            | 2,3                             | 1              |
| 0            | 3                               | 1              |
| 0            | 0,1,2,4,5,6,7,8                 | 0              |