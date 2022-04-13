program example1

  ! A simple iteration

  implicit none

  integer :: i = 0

  do
    i = i + 1
    if (mod(i, 2) == 0) cycle    ! go to the next iteration
    if (i >= 10) exit            ! exit loop completely
    print *, "Iteration: ", i
  end do

  ! ... control continues here after exit ...
  print *, "At end of iteration: ", i

end program example1
