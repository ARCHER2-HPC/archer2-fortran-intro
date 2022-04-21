program program1

  ! Exercise: correct the intent of the dummy argument in the
  ! accompanying module1.f90

  use module1
  implicit none

  real :: x

  call assign_x(x)
  call print_x(x)
  call increment_x(x)
  call print_x(x)

end program program1
