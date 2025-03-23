program exercise1

  ! Exercise to introduce array storage

  ! Here's a version of the pi program
  ! See, e.g., https://en.wikipedia.org/wiki/Pi
  !
  ! If we initialise:
  !
  !   a_0 = 1, b_0 = 1/sqrt(2), t_0 = 1/4, p_0 = 1
  !
  ! and perform the iteration
  !
  !   a_{n+1} = (a_n + b-n)/2
  !   b_{n+1} = sqrt(a_n b_n)
  !   t_{n+1} = t_n - p_n (a_n - a_{n+1})^2   with p_{n+1} = 2p_n
  !
  !  then
  !
  !   pi_n \approx (a_n + b_n)^2/4t_n
  !
  ! Exercise:
  ! Decide on a fixed number of iterations, and introduce arrays of
  ! appropriate size for the quantities a, b, and t. Use a first
  ! loop to assign values to these three quantities.


  implicit none

  integer, parameter :: kp = kind(1.d0)

  real (kp) :: a = 1.0_kp
  real (kp) :: b = 1.0/sqrt(2.0_kp)
  real (kp) :: t = 0.25_kp
  real (kp) :: p = 1.0_kp

  real (kp) :: an
  integer   :: n = 0

  do
    print *, "Approximation n, pi: ", n, (a + b)**2/(4.0*t)
    if (n > 6) exit

    an = a

    a = (an + b)/2.0
    b = sqrt(an*b)
    t = t - p*(an - a)**2
    p = 2.0*p
    n = n + 1
  end do

end program exercise1
