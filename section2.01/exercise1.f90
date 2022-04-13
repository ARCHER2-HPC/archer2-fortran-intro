program exercise1

  ! Compute an approximation to pi.
  
  ! An approximation using the Gauss-Legendre algorithm
  ! See, e.g., https://en.wikipedia.org/wiki/Pi
  !
  ! If we initialise:
  !
  !   a_0 = 1
  !   b_0 = 1/sqrt(2)
  !   t_0 = 1/4
  !   p_0 = 1
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
  !  Compute the first two approximations pi_0 and pi_1.
  
end program exercise1
