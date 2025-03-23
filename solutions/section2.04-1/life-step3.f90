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
  integer, dimension(nrow, ncol, 2) :: board

  ! An array of characters to hold one row in the picture

  character (len = ncol) :: line

  integer :: i, j
  integer :: ntnow, ntnew
  integer :: nt, ntmp
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

  ntnow = 1 ! current time level
  ntnew = 2 ! new time level

  board(:, :, 1:2)      = 0

  board(9:13, 9, ntnow) = 1
  board( 9,  11, ntnow) = 1
  board(13,  11, ntnow) = 1
  board(9:13,13, ntnow) = 1

  ! Step (4 steps only)
  do nt = 1, 4

    print *, "Step ", nt

    do i = 2, nrow - 1
      do j = 2, ncol - 1
        ! count live neighbours for (i, j) (not counting self)
        nlive = board(i-1, j-1, ntnow) + board(i,   j-1, ntnow) + board(i+1, j-1, ntnow) &
              + board(i-1, j,   ntnow) +                          board(i+1, j,   ntnow) &
              + board(i-1, j+1, ntnow) + board(i,   j+1, ntnow) + board(i+1, j+1, ntnow)

        if (board(i, j, ntnow) == 1) then
          select case (nlive)
            case (0, 1)
              board(i, j, ntnew) = 0
            case (2, 3)
              board(i, j, ntnew) = 1
            case default
              board(i, j, ntnew) = 0
          end select
        else
          select case (nlive)
            case (3)
              board(i, j, ntnew) = 1
            case default
              board(i, j, ntnew) = 0
            end select
        end if
      end do

      ! Set the row output for the current step
      do j = 1, ncol
        if (board(i, j, ntnow) == 1) then
          line(j:j) = '#'
        else
          line(j:j) = '.'
        endif
      end do

      print *, line
    end do

    ! swap the current and the new board and next time step...
    ntmp  = ntnew
    ntnew = ntnow
    ntnow = ntmp
  end do

end program game_of_life
