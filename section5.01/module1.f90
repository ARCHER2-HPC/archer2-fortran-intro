module module1

  ! A simple linear congruential generator

  use iso_fortran_env
  implicit none

  type, public :: my_rng
    integer (int64) :: a = 45991
    integer (int32) :: s = 1
    integer (int64) :: c = 0
    integer (int64) :: m = 2147483647
  end type my_rng

contains

  function my_rng_int(rng) result(inext)

    ! Update the state and return the new value

    type (my_rng), intent(inout) :: rng
    integer (int32)              :: inext

    integer (int64) :: s

    s = int(rng%s, int64)
    rng%s = int(mod(rng%a*s + rng%c, rng%m), int32)
    inext = rng%s

  end function my_rng_int

end module module1
