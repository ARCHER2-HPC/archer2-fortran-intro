module module1

  ! Exercise: correct the intent of the dummy arguments

  implicit none
  public

contains

  subroutine assign_x(x)

    real, intent(in) :: x

    x = 1.0

  end subroutine assign_x

  subroutine print_x(x)

    real, intent(in) :: x

    print *, "The value of x is: ", x

  end subroutine print_x

  subroutine increment_x(x)

    real, intent(in) :: x

    x = x + 1.0

  end subroutine increment_x

end module module1
