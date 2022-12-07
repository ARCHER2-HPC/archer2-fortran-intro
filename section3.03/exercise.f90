program exercise

  ! Tri-diagonal matrix problem via Thomas' algorithm
  ! See https://en.wikipedia.org/wiki/Tridiagonal_matrix_algorithm

  ! The following values are used as a test:
  !   a =      [1.0, 1.0, 1.0]                - lower diagonal
  !   b = [4.0, 4.0, 4.0, 4.0]                - diagonal
  !   c = [2.0, 2.0, 2.0]                     - upper diagonal
  !   d = [1.0, 4.0, 5.0, 6.0]                - rhs
  ! which should give a solution approx. x = [-0.195, 0.890, 0.317, 1.42]


  use iso_fortran_env
  implicit none

  integer, parameter :: mykind = real32
  integer, parameter :: nmax = 4

  real (mykind), dimension(nmax)      :: b = [4.0, 4.0, 4.0, 4.0]
  real (mykind), dimension(2:nmax)    :: a = [1.0, 1.0, 1.0]
  real (mykind), dimension(1:nmax-1)  :: c = [2.0, 2.0, 2.0]
  real (mykind), dimension(nmax)      :: d = [1.0, 4.0, 5.0, 6.0]
  real (mykind), dimension(nmax)      :: x

  real (mykind) :: w
  integer :: i

  ! Set up the matrix here: all elements; diagonal elements, then
  ! off-diagonal elements

  ! Solve via Thomas' algorithm
  ! Note b(:) and d(:) are destroyed

  do i = 2, nmax
    w = a(i) / b(i-1)
    b(i) = b(i) - w*c(i-1)
    d(i) = d(i) - w*d(i-1)
  end do

  x(:) = d(:)/b(:)

  do i = nmax-1, 1, -1
    x(i) = (d(i) - c(i)*x(i+1))/b(i)
  end do

  print *, "Solution ", x(:)

end program exercise
