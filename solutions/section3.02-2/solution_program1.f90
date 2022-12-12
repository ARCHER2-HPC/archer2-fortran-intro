program exercise_program1

  ! Functions and subroutines

  use exercise_module1
  implicit none

  integer :: n
  real    :: fn, pi

  print *, "pi: ", pi_gauss_legendre()

  call pi_gauss_legendre_sub(1, pi)
  print *, "pi_1: ", pi

  do n = 1, 12
     print *, "n, F_n: ", n, fibonacci(n)
  end do

end program exercise_program1
