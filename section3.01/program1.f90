program program1

  use module1
  implicit none

  real (kind = mykind) :: a

  a = pi_mykind()

  print *, "Module mykind: ", mykind
  print *, "Value of a:    ", a

end program program1
