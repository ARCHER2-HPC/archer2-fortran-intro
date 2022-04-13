program example1

  ! Example: exit from a nested loop.

  implicit none

  integer :: i = 0

  some_outer_loop: &
  do
    some_inner_loop: &
    do
      if (i >= 10) exit some_outer_loop
      print *, "Inner iteration after exit ", i
      i = i + 1
    end do some_inner_loop
    print *, "Never get here"
  end do some_outer_loop

  print *, "End of iteration"

end program example1
