module solution_module

  ! Module version of the Gauss-Legendre evaluation of pi

  implicit none
  public

  integer, parameter :: kp = kind(1.d0)

contains

  function pi_gauss_legendre() result(pi)

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

end module solution_module
