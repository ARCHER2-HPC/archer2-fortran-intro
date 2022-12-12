module exercise_module1

  ! Functions and subroutines
  !
  ! 1. Check the existing pi_gauss_legendre() can be declared pure
  ! 2. Add a subroutine pi_gauss_legendre(nmax, pi)
  ! 3. Add a recursive function fibonacci(n)

  implicit none
  public

  integer, parameter :: kp = kind(1.d0)

contains

  pure function pi_gauss_legendre() result(pi)

    integer, parameter :: nmax = 10

    real (kp) :: pi

    real (kp) :: a, an, b, t, p
    integer   :: n

    ! Initial values, and iterate ...
    a = 1.0_kp
    b = 1.0/sqrt(2.0_kp)
    t = 0.25_kp
    p = 1.0_kp

    do n = 1, nmax
      an = a
      a = (an + b)/2.0
      b = sqrt(an*b)
      t = t - p*(an - a)**2
      p = 2.0*p
    end do

    pi = (a + b)**2/(4.0*t)

  end function pi_gauss_legendre

  !---------------------------------------------------------------------------

  subroutine pi_gauss_legendre_sub(nmax, pi)

    ! We use the default real here.

    integer, intent(in)  :: nmax
    real,    intent(out) :: pi

    real    :: a, an, b, t, p
    integer :: n

    ! Initial values, and iterate ...
    a = 1.0
    b = 1.0/sqrt(2.0)
    t = 0.25
    p = 1.0

    do n = 1, nmax
      an = a
      a = (an + b)/2.0
      b = sqrt(an*b)
      t = t - p*(an - a)**2
      p = 2.0*p
    end do

    pi = (a + b)**2/(4.0*t)

  end subroutine pi_gauss_legendre_sub

  !---------------------------------------------------------------------------

  recursive function fibonacci(n) result(fn)

    ! nth fibonacci number for n >= 1, with f_1 = 1, f_2 = 1, ...
    ! n <= 0 might be treated as erroneous

    integer, intent(in) :: n
    integer             :: fn

    if (n <= 0) then
       fn = 0
    else if (n <= 2) then
       fn = 1
    else
       fn = fibonacci(n-1) + fibonacci(n-2)
    end if

  end function fibonacci

end module exercise_module1
