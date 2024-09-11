program game_of_life

    ! construct an array large enough to represent the starting state
    integer, parameter :: nrow = 21, ncol = 21
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
    board(:,:) = 0
    board(9:13,9) = 1
    board(9,11) = 1
    board(13,11) = 1
    board(9:13,13) = 1

    !  1. Print to screen the initial view of the board.
    !  2. Iterate over the array (the board) updating the current cell
    !      based on the state of the neighbouring cells.
    !  3. We are using the integers 1 and 0 to represent live and dead,
    !      but boolean (true/false) values could have been used.
    !  4. Print to screen the view of the board after this first iteration.

    ! HINT: Printing to screen
    ! The output is printed row by row, so we could create the row characters like this:
    ! 
    ! do i=1, nrow
    !   output = ""
    !   do j=1, ncol
    !       if (board(i,j) == 1) then
    !           output = trim(output)//"#"
    !       else
    !           output = trim(output)//"."
    !    ...
    !    ...
    
    ! trim() - this is used to remove trailing blank characters of a string.



end program game_of_life