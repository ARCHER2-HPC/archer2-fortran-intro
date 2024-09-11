program game_of_life
    ! =====================
    ! Conway's Game of Life
    ! =====================

    ! Conway's game of life is a cellular automaton where a 2D 
    ! grid of "cells" are said to be "alive" (1) or "dead" (0).
    ! Iterating over the array, we update the live/dead state of the 
    ! cells based on a set of rules. These rules are based on the 
    ! number of neighbouring cells that are alive or dead. A single
    ! cell has 8 neighbours, therefore we need to examine the 8
    ! neighbouring cells to determine the living state of the centre
    ! cell.

    ! The "rules" are based on the total number of living cells surrounding
    ! our centre cell.
    !
    ! Cell state   N (neighbouring live cells)     New C state
    ! 1            0,1                         ->  0       # Lonely
    ! 1            4,5,6,7,8                   ->  0       # Overcrowded
    ! 1            2,3                         ->  1       # Lives
    ! 0            3                           ->  1       # Birth
    ! 0            0,1,2,4,5,6,7,8             ->  0       # Empty
    
    implicit none
    
    ! Use an array large enough to contain the pattern as it 
    ! expands over multiple iterations. 
    integer, parameter :: nrow = 21, ncol = 21
    integer :: i, j, sum
    integer, dimension(nrow, ncol) :: board, nextBoard
    
    ! Chars for the output printing
    character(nrow) :: output
    
    ! Initialise the starting state of the board.
    ! The central section of the 21x21 grid looks like this:
    ! .........
    ! ..#.#.#..
    ! ..#...#..
    ! ..#...#..
    ! ..#...#..
    ! ..#.#.#..
    ! .........
    board(:,:) = 0
    board(9:13,9) = 1
    board(9,11) = 1
    board(13,11) = 1
    board(9:13,13) = 1

    ! nextBoard stores the next iteration of board. 
    ! It needs to be zero-ed to begin with
    nextBoard = 0

    ! Print the initial board set up
    print *, "Initial Board Set-up:"
    do i=1, nrow
        output = ""
        do j=1, ncol
            if (board(i,j) == 1) then
                output = trim(output)//"#"
            else
                output = trim(output)//"."
            endif
        enddo
        print *, output
    enddo

    ! Calculate the next step of the game of life.
    do i=2, nrow-1
        do j=2, ncol-1
            sum = 0
            sum = board(i-1, j-1) + board(i, j-1) + board(i+1, j-1)
            sum = sum + board(i-1, j) + board(i+1, j)
            sum = sum + board(i-1, j+1) + board(i, j+1) + board(i+1, j+1)
            if(board(i,j).eq.1 .and. sum.le.1) then
                nextBoard(i,j) = 0
            elseif(board(i,j).eq.1 .and. sum.le.3) then
                nextBoard(i,j) = 1
            elseif(board(i,j).eq.1 .and. sum.ge.4) then
                nextBoard(i,j) = 0
            elseif(board(i,j).eq.0 .and. sum.eq.3) then
                nextBoard(i,j) = 1
            endif
        enddo
    enddo 

    ! print newline
    print *, ""

    ! Write the next iteration of the board
    print *, "First iteration of the GoL rules:"
    do i=1, nrow
        output = ""
        do j=1, ncol
            if (nextBoard(i,j) == 1) then
                output = trim(output)//"#"
            else
                output = trim(output)//"."
            endif
        enddo
        print *, output
    enddo

end program game_of_life