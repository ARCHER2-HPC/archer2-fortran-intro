program game_of_life

  ! Exercise to run the "Game of Life"

  implicit none

  ! Size of the "board". An odd number is chosen so that the initial
  ! pattern has rotational symmetry around the central point in the
  ! square system.

  ! We will use the integers 1 and 0 to represent "live" and "dead",
  ! represetively. A boolean (true/false) value could have be used.

  integer, parameter :: nrow = 21
  integer, parameter :: ncol = 21
  integer, dimension(nrow, ncol) :: board

  ! Initialise the starting state of the board.
  ! The central section of the 21x21 grid looks like this:
  ! .........
  ! ..#.#.#..
  ! ..#...#..
  ! ..#...#..
  ! ..#...#..
  ! ..#.#.#..
  ! .........

  board(:, :)    = 0
  board(9:13, 9) = 1
  board( 9,  11) = 1
  board(13,  11) = 1
  board(9:13,13) = 1

  !  1. Output to screen the initial view of the board.

  ! HINT:
  ! The output is printed row by row, so we could create the row of characters
  ! something like this:
  !  a. declare an array of characters to hold one row of the board
  !     (here called "line");
  !  b. for each column, set either "live" or "dead";
  !  c. at the end of each row, print the whole array of characters.

  !  do i = 1, nrow
  !    do j = 1, ncol
  !      if (board(i, j) == 1) then
  !        ! set "live" character "#" for this column
  !      else
  !        ! set "dead" character "." for this column
  !      end if
  !    end do
  !  ! Print current row ..
  !  end do


  ! 2. Compute and output the new state for each position of the board ...
  !    HINT
  !    Do not try, at this stage, anything at the perimeter.
  !    Do not try to update the board; just use the character array
  !    to record and output the new state.


  ! 3. Time stepping, run and output the first four or five steps
  !    using an additional outer loop over the time step.
  !    HINT
  !    a. You will need some way to "remember" the previous state
  !       as well as holding the current state. With some thought,
  !       you should be able to do this using a board of dimensions
  !       dimesnion(nrow, ncol, 2), where the third dimension holds
  !       two time levels.
  !    b. It should not be necessary to copy the contents of the board
  !       "between time levels"; just use the time level index.
  !    c. Print the time  at each step to separate the picture of
  !       the time levels.

end program game_of_life
