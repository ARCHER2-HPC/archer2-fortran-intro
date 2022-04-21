program example1

  implicit none

  integer, dimension(4, 8) :: a1, a2
  integer, dimension(4)    :: b1

  a1 = 0
  a2 = a1 + 1
  a1 = 2*a2

  ! Set b1 to be the first column of a1
  b1 = a1

  print *, "b1 is: ", b1

  ! Set b1 to first half of first row of a2()
  b1(1:4) = a2(1, 4:4)

  print *, "b1 is: ", b1

end program example1
