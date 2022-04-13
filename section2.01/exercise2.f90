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
  !  Compute the first term in the series (i.e., k = 1):
  !
  !  C_1 = (4/3) b c^3 [ 1 - 6(c/b) tanh(a_k b/c) / a_k^5 ]
  !
  !  We will use the sample values w = 62, h = 30.
  !
  !  You will need the intrinsic function tanh() for hyperbolic tangent.
  !
  !  Your result should be in the region of 97227.88 ( the exact figure
  !  depending on precision).

  !  Try for both real32 and real64.
  !  Does your compiler support kind real128? 

end program exercise2
