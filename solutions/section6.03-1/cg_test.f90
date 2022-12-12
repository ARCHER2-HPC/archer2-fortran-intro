program cg_test

  ! Conjugate gradient test problem

  use cgradient
  implicit none

  integer, parameter :: nmax = 4

  real (k_real), dimension(nmax, nmax) :: a
  real (k_real), dimension(nmax)       :: b
  real (k_real), dimension(nmax)       :: x
  real (k_real) :: tol = 0.0001
  integer :: ierr

  ! a must be symmetric
  a(1,:) = [ 4.0, 1.0, 0.0, 0.0 ]
  a(2,:) = [ 1.0, 4.0, 1.0, 0.0 ]
  a(3,:) = [ 0.0, 1.0, 4.0, 1.0 ]
  a(4,:) = [ 0.0, 0.0, 1.0, 4.0 ]

  b(:)   = [ 1.0, 4.0, 5.0, 6.0 ]

  ! initial guess
  x(:) = 1.0

  call cg_solve(a, b, tol, x, ierr)

  print *, "ierr:    ", ierr
  print *, "Solution ", x(:)
  print *, "Check b:  ", matmul(a, x)

end program cg_test
