program example2

  ! Use int32 and real64 kind type parameters from iso_fortran_env
  ! to determine the precision of variables.

  ! Note that the use statement must be before the implicit none,
  ! which should preceed the declarations.

  use iso_fortran_env, only : int64, real64
  implicit none

  integer (kind = int64)   :: i = 100
  real    (kind = real64)  :: a = 1.0
  complex (kind = real64)  :: z = (0.0, 1.0)

  print *, "The value of i:  ", i
  print *, "The value of a:  ", a
  print *, "The value of c:  ", z

end program example2
