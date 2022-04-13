program example1

  ! Default numeric types with some initial values

  implicit none

  integer :: i = 1              ! A default integer kind
  real    :: a = 2.0            ! A default floating point kind
  complex :: z = (0.0, 1.0)     ! A complex kind with (real-part, imag-part)

  print *, "The value of i:  ", i
  print *, "The value of a:  ", a
  print *, "The value of c:  ", z

end program example1
