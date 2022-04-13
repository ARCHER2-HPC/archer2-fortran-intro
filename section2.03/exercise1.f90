program exercise1

  ! Here's a version of the program that computes the two roots of
  !   a x^2 + b x + c = 0
  ! as real numbers, and then as complex numbers.
  !
  ! Make sure you can replace the two real variable roots (x1r, x1i) and
  ! (x2r, x2i) by two arrays of extent 2, one for each root. Use array
  ! constructors to combine real and imaginary parts in the if blocks.
  !
  ! Replace the separate complex roots z1 and z2 by a single array.
  !
  ! Some values for (a,b,c) might be
  !   a = 1.0, b =  5.0, c = 6.0     (=> two real roots)
  !   a = 2.0, b =  1.0, c = 5.0/8.0 (=> two complex roots)
  !   a = 4.0, b = -8.0, c = 4.0     (=> two equal roots)

  implicit none

  real :: a = 1.0, b = 5.0, c = 6.0
  real :: d

  real, dimension(2) :: x1
  real, dimension(2) :: x2

  d = b*b - 4.0*a*c

  if (d > 0.0) then
     print *, "Two real roots"
     x1(1:2) = (/ (-b + sqrt(d))/(2.0*a), 0.0 /)
     x2(1:2) = (/ (-b - sqrt(d))/(2.0*a), 0.0 /)
  else if (d < 0.0) then
     print *, "Two complex roots"
     x1(1:2) = (/ -b/(2.0*a), +sqrt(-d)/(2.0*a) /)
     x2(1:2) = (/ -b/(2.0*a), -sqrt(-d)/(2.0*a) /)
  else
     print *, "Two equal roots"
     x1(1:2) = [ -b/(2.0*a) , 0.0 ]
     x2(1:2) = x1(1:2)
  end if

  print *, "Real values x1 = ", x1
  print *, "Real values x2 = ", x2

  ! Use complex numbers

  block
    complex, dimension(2) :: z
    complex :: zd

    zd = cmplx(d)
    z(1) = (-b + sqrt(zd))/(2.0*a)
    z(2) = (-b - sqrt(zd))/(2.0*a)
    print *, "Complex     z1 = ", z(1)
    print *, "Complex     z2 = ", z(2)
  end block

end program exercise1
