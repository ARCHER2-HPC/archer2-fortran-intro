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

  ! An array of characters to hold one row in the picture

  character (len = ncol) :: line

  integer :: i, j
  integer :: nlive

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
  !  2. Iterate over the array (the board) updating the current cell
  !      based on the state of the neighbouring cells.
  !  4. Output to screen the view of the board after this first iteration.

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
  !    Do not try, at this stage, anything at the perimeter.
  !    Do not try to update the board.

  do i = 2, nrow - 1
    do j = 2, ncol - 1
      ! count live neighbours for (i, j) (not counting self)
      nlive = board(i-1, j-1) + board(i,   j-1) + board(i+1, j-1) &
            + board(i-1, j  ) +                   board(i+1, j  ) &
            + board(i-1, j+1) + board(i,   j+1) + board(i+1, j+1)

      if (board(i, j) == 1) then
         select case (nlive)
         case (0, 1)
            line(j:j) = "."
         case (2, 3)
            line(j:j) = "#"
         case default
            line(j:j) = "."
         end select
      else
         select case (nlive)
         case (3)
            line(j:j) = '#'
         case default
            line(j:j) = '.'
         end select
      end if
     end do
     ! print those elements we have updated ...
     print *, line(2:ncol-1)
   end do

   ! 3. Output this new state as above...

end program game_of_life
