module module1

  implicit none

  integer, parameter :: mykind = kind(1.d0)

contains

  function pi_mykind() result(pi)

    ! Return the value of a well-known constant

    real (kind = mykind) :: pi

    pi = 4.0*atan(1.0_mykind)

  end function pi_mykind

end module module1
