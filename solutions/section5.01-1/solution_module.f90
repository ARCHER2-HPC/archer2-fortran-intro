module solution_module

  ! Tri-diagonal matrix problem via Thomas' algorithm
  ! See https://en.wikipedia.org/wiki/Tridiagonal_matrix_algorithm

  ! This version with a derived type

  use iso_fortran_env
  implicit none

  integer, parameter :: mykind = real32

  type, public :: tri_matrix
    integer :: nmax
    real (mykind), dimension(:), allocatable :: a     ! lower (2:nmax)
    real (mykind), dimension(:), allocatable :: b     ! diag (1:nmax)
    real (mykind), dimension(:), allocatable :: c     ! upper (1:nmax-1)
  end type tri_matrix

contains

  function tri_matrix_from_arrays(b, a, c) result(matrix)

    ! We expect:
    !   b(1:nmax)                  diagonal elements
    !   a(2:nmax)                  lower diagonal elements
    !   c(1:nmax-1)                upper diagonal elements

    real (mykind), dimension(1:), intent(in) :: b
    real (mykind), dimension(2:), intent(in) :: a
    real (mykind), dimension(1:), intent(in) :: c
    type (tri_matrix)                        :: matrix

    integer :: ierr(3)

    ierr(:) = 0

    matrix%nmax = size(b)
    allocate(matrix%b(1:matrix%nmax  ), stat = ierr(1))
    allocate(matrix%a(2:matrix%nmax  ), stat = ierr(2))
    allocate(matrix%c(1:matrix%nmax-1), stat = ierr(3))

    matrix%b(:) = b(:)
    matrix%a(:) = a(:)
    matrix%c(:) = c(:)

    if (any(ierr(:) /= 0)) print *, "We have limited error handling"

  end function tri_matrix_from_arrays

  function tri_matrix_from_scalars(nmax, b, a) result(matrix)

    ! We expect:
    !   nmax     number of elements on diagonal
    !   b        diagonal elements, single value for
    !   a        off-diagonal elements, single value for

    integer,       intent(in) :: nmax
    real (mykind), intent(in) :: b
    real (mykind), intent(in) :: a
    type (tri_matrix)         :: matrix

    integer :: ierr(3)

    ierr(:) = 0

    matrix%nmax = nmax
    allocate(matrix%b(1:nmax),   stat = ierr(1))
    allocate(matrix%a(2:nmax),   stat = ierr(2))
    allocate(matrix%c(1:nmax-1), stat = ierr(3))

    if (any(ierr(:) /= 0)) print *, "We have limited error handling"

    matrix%b(:) = b
    matrix%a(:) = a
    matrix%c(:) = a

  end function tri_matrix_from_scalars

  subroutine tridiagonal_solve(matrix, rhs, x)

    ! Routine to solve system for
    !   rhs(1:nmax)                right-hand side
    !   x(1:nmax)                  solution on exit

    type (tri_matrix),            intent(in)  :: matrix
    real (mykind), dimension(1:), intent(in)  :: rhs
    real (mykind), dimension(1:), intent(out) :: x

    real (mykind), dimension(matrix%nmax) :: blocal   ! local copy of b
    real (mykind), dimension(matrix%nmax) :: rlocal   ! local copy of rhs

    integer :: i
    real (mykind) :: w

    blocal(:) = matrix%b(:)
    rlocal(:) = rhs(:)

    ! Solve via Thomas' algorithm

    do i = 2, matrix%nmax
      w = matrix%a(i) / blocal(i-1)
      blocal(i) = blocal(i) - w*matrix%c(i-1)
      rlocal(i) = rlocal(i) - w*rlocal(i-1)
    end do

    x(:) = rlocal(:)/blocal(:)

    do i = matrix%nmax-1, 1, -1
      x(i) = (rlocal(i) - matrix%c(i)*x(i+1))/blocal(i)
    end do

  end subroutine tridiagonal_solve

  subroutine tri_matrix_destroy(matrix)

    type(tri_matrix), intent(out) :: matrix

    matrix = tri_matrix(0, null(), null(), null())

  end subroutine tri_matrix_destroy

end module solution_module
