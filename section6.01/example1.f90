program example1

  ! Calling a external function

  ! 1, Add an extern declaration to allow the program to compile
  ! 2. Replace the extern declaration by an interface which is
  !    consistent with the definition of array_size() as it
  !    appears in external.f90. What new error has the interface
  !    exposed?

  implicit none

  real, dimension(3,2) :: a

  ! Place an external declaration or interface block (not both) here.

  print *, "The array size is: ", array_size(a), size(a)

end program example1
