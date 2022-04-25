  function array_size(a) result(isize)

    real, dimension(:), intent(in) :: a
    integer                        :: isize

    isize = size(a)

  end function array_size
