module exercise_module

  ! Tri-diagonal matrix problem via Thomas' algorithm
  ! See https://en.wikipedia.org/wiki/Tridiagonal_matrix_algorithm

  use iso_fortran_env
  implicit none

  integer, parameter :: mykind = real32

contains

  subroutine tridiagonal_solve(b, a, c, rhs, x)

    ! Routine to solve system for
    !   b(1:nmax)                  diagonal elements
    !   a(2:nmax)                  lower diagonal elements
    !   c(1:nmax-1)                upper diagonal elements
    !   rhs(1:nmax)                right-hand side
    !   x(1:nmax)                  solution on exit

    real (mykind), dimension(1:), intent(in)  :: b
    real (mykind), dimension(2:), intent(in)  :: a
    real (mykind), dimension(1:), intent(in)  :: c
    real (mykind), dimension(1:), intent(in)  :: rhs
    real (mykind), dimension(1:), intent(out) :: x

    real (mykind), dimension(size(b)) :: blocal       ! local copy of b
    real (mykind), dimension(size(b)) :: rlocal       ! local copy of rhs

    integer :: nmax
    integer :: i
    real (mykind) :: w

    nmax = size(b)
    blocal(1:nmax) = b(1:nmax)
    rlocal(1:nmax) = rhs(1:nmax)

    ! Solve via Thomas' algorithm

    do i = 2, nmax
      w = a(i) / blocal(i-1)
      blocal(i) = blocal(i) - w*c(i-1)
      rlocal(i) = rlocal(i) - w*rlocal(i-1)
    end do

    x(:) = rlocal(:)/blocal(:)

    do i = nmax-1, 1, -1
      x(i) = (rlocal(i) - c(i)*x(i+1))/blocal(i)
    end do

  end subroutine tridiagonal_solve

end module exercise_module
