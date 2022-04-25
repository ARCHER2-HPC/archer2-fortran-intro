program example2

  ! Use of associate construct

  implicit none

  real, dimension(7) :: r1 = [ 1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0 ]

  associate(p => r1(2::2))
    print *, "Pointer section size: ", size(p)
    print *, "Pointer section:      ", p
    p = 0.0
  end associate

  print *, "Original at exit ", r1(:)

end program example2
