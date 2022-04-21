program example2

  implicit none

  character (len = :), allocatable :: string

  string = "ABCD"
  print *, "string: ", string, len(string)

  string = "ABCDEFG"
  print *, "string: ", string, len(string)

end program example2
