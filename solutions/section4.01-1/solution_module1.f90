module exercise_module1

  ! String functions exercise.

  implicit none
  public

contains

  subroutine string_to_lower_case(str)

    ! Force str to be lower case

    character (len = *), intent(inout) :: str

    integer, parameter :: iA = iachar('A')
    integer, parameter :: iZ = iachar('Z')

    integer :: i, j

    do i = 1, len_trim(str)
      j = iachar(str(i:i))
      if (iA <= j .and. j <= iZ) str(i:i) = achar(j+32)
    end do

  end subroutine string_to_lower_case

  !---------------------------------------------------------------------------

  function to_lower_case(str) result(lower_case)

    ! Return a new lower case version of string

    character (len = *), intent(in)  :: str
    character (len = :), allocatable :: lower_case

    lower_case = trim(str)
    call string_to_lower_case(lower_case)

  end function to_lower_case

end module exercise_module1
