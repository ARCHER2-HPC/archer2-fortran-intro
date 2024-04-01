program integral_program

  use integral_module
  implicit none

  ! Quadrature of the function my_cos_sin using n points
  ! The answer for [0, pi/2] should be one half

  real, parameter :: pi = 4.0*atan(1.e0)
  real            :: a = 0.0
  real            :: b = 0.5*pi
  integer         :: n

  do n = 1, 3
    print *, "Answer: ", 10**n, my_integral(a, b, 10**n, my_cos_sin)
  end do

end program integral_program
