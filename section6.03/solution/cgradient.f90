module cgradient

  ! Conjugate gradient example
  ! We we use the real kind k_kind

  implicit none

  integer, parameter :: k_real = kind(1.e0)

contains

  subroutine cg_solve(a, b, tol, x, ierr)

    ! The initial guess x will be replaced by the solution on exit

    real (k_real), dimension(:,:), intent(in)    :: a     ! matrix
    real (k_real), dimension(:),   intent(in)    :: b     ! rhs
    real (k_real),                 intent(in)    :: tol   ! tolerance
    real (k_real), dimension(:),   intent(inout) :: x
    integer,                       intent(out)   :: ierr

    real (k_real), dimension(size(x)) :: r
    real (k_real), dimension(size(x)) :: p
    real (k_real), dimension(size(x)) :: ap

    real (k_real) :: rsqold

    ! Checks:
    ! One could check here that all the inputs are of the right shape.
    ! The matrix a must be symmetric.
    ierr = 0

    ! Compute initial residual vector r =  b - Ax
    r(:) = b(:) - matmul(a, x)
    rsqold  = sum(r(:)*r(:))

    if (rsqold < tol) then
       ! x(:) is the solution...
    else 

       p(:) = r(:)
       do
          block
            real (k_real) :: alpha
            real (k_real) :: beta
            real (k_real) :: rsq

            ! Compute and store Ap as we need it twice
            ap = matmul(a, p)
            ! alpha = r.r / pAp
            alpha = rsqold / sum(p(:)*ap(:))
            x(:) = x(:) + alpha*p(:)
            r(:) = r(:) - alpha*ap(:)
            ! Check for exit
            rsq = sum(r(:)*r(:))
            if (rsq < tol) exit
            beta = rsq/rsqold
            p(:) = r(:) + beta*p(:)
            rsqold = rsq
          end block
       end do
       ! x(:) is the solution ...
    end if
    
  end subroutine cg_solve

end module cgradient
