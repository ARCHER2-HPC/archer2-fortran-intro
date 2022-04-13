program example2

  ! Loop trip count: check for each case ...

  implicit none

  integer :: i

  print *, "First loop: 1, 10"
  do i = 1, 10
    print *, "i is ", i
  end do

  print *, "Second loop: 1, 10, -2"
  do i = 1, 10, -2
    print *, "i is ", i
  end do

  print *, "Third loop: 10, 1, -2"
  do i = 10, 1, -2
    print *, "i is ", i
  end do

end program example2
