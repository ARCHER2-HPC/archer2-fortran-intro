program example3

  ! Character parameter array example

  implicit none

  character (len = *), dimension(7), parameter :: days =                  &
       ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", &
        "Saturday"]

  integer :: n

  do n = 1, 7
    print *, days(n), len(days(n)), len_trim(days(n))
  end do

end program example3
