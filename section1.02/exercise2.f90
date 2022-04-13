program exercise2

  ! Debug this program

  implicit none

  integer, parameter :: nmax = 32              ! A constant
  real,    parameter :: pi = 4.0*atan(1.e0)    ! A well-known constant
  complex, parameter :: zi = (0.0, 1.0)        ! square root of -1

  nmax = 33
  
  print *, "The value of nmax:   ", nmax
  print *, "The value of pi:     ", pi
  print *, "The value of ci:     ", zi

end program exercise2
