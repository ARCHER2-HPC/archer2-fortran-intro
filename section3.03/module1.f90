module module1

  ! Provides a subroutine to add a to b

  implicit none
  public

contains

  subroutine array_action2(a, b)

    real, dimension(:,:), intent(in)    :: a
    real, dimension(:,:), intent(inout) :: b

    b(:,:) = b(:,:) + a(:,:)

  end subroutine array_action2

end module module1
