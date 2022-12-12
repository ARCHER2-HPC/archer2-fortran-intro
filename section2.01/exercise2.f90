program exercise2

  ! Compute an approximation to the conductance of a narrow channel.

  ! The steady volume flux (volume flow rate) Q in a rectangular
  ! capillary of cross section width x height 2b x 2c (with 2b > 2c)
  ! we can write:
  !
  !    Q = -C (dp/dx) / eta
  !
  ! with dp/dx the pressure gradient and eta the dynamic viscosity.
  ! One can define a viscosity-independent conductance C
  !
  !    C = (4/3) b c^3 [ 1 - 6(c/b) \sum_k tanh (a_k b/c)/a_k^5 ]
  !
  ! where a_k = (2k - 1) pi/2 and the sum is k = 1, ..., \inf.
  !
  ! E.g. T. Papanastasiou, G. Georiou, and A. Alexandrou,
  ! "Viscous Fluid Flow" CRC Press, Boca Raton, Florida (2000).

  !  Exercise
  !  Use a loop to compute a fixed number of terms in the sum over
  !  index k. Convergence may be rather slow (check by printing out
  !  the current value every 20 iterations.
  !
  !  We will use the sample values w = 62, h = 30. The template below
  !  computes only the first term k = 1.


  use iso_fortran_env
  implicit none

  integer, parameter :: kp = real64

  real (kp), parameter :: pi = 4.0*atan(1.0)
  real (kp), parameter :: w = 62.0
  real (kp), parameter :: h = 30.0

  real (kp) :: a, b, c
  real (kp) :: conductance

  a = 0.5*pi
  b = 0.5*w
  c = 0.5*h

  ! First term only
  conductance = (4.0/3.0)*b*(c**3)*(1.0 - 6.0*(c/b)*tanh(a*b/c)/a**5)

  ! Some appropriate output might be ...
  print *, "Value of w:       ", w
  print *, "Value of h:       ", h
  print *, "Value of pi:      ", pi
  print *, "Approximation is: ", conductance

end program exercise2
