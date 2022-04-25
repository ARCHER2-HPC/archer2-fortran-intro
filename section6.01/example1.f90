program example1

  ! Calling a external function

  implicit none

  real, dimension(3,2) :: a

  ! Place an external declaration or interface block (not both) here.

  print *, "The array size is: ", array_size(a), size(a)

end program example1
