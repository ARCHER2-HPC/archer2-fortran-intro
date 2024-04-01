module integral_module

  implicit none

contains

  ! A function to define an integrand

  function my_cos_sin(x) result(fx)
    real, intent(in) :: x
    real             :: fx
    fx = cos(x)*sin(x)
  end function my_cos_sin

  ! A function to perform a numerical integration of afunc over the
  ! interval [a,b] split into n divisions via a simple trapezoidal
  ! method
    
  function my_integral(a, b, n, afunc) result(val)

    real,    intent(in) :: a, b
    integer, intent(in) :: n
    real                :: val
    interface
       function afunc(x) result(y)
         real, intent(in) :: x
         real                y
       end function afunc
    end interface

    integer :: k
    real    :: h, sum

    h = (b - a)/n
    sum = 0
    do k = 1, n-1
       sum = sum + 2.0*afunc(a + k*h)
    end do

    val = 0.5*h*(afunc(a) + sum + afunc(b))

  end function my_integral

end module integral_module
