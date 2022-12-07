program example2

  ! Some character variables

  implicit none

  character (len = *), parameter :: string1 = "don't"   ! 5 characters
  character (len = 5)            :: string2 = "Don""t"  ! 5 characters
  character (len = 6)            :: string3 = 'don''t'  ! 5 characters + blank

  print *, "string1: ", string1
  print *, "string2: ", string2
  print *, "string3: ", string3

  print *, "Catenated:       ", string3//string2//string1
  print *, "Substring:       ", string2(1:2)
  print *, "kind('A'):       ", kind('A')

end program example2
