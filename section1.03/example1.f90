program example1

  implicit none

  integer :: i = 1
  integer :: j = 2
  logical :: condition1
  logical :: condition2

  condition1 = (i < j)
  condition2 = (i > j)

  if (condition1) then
    print *, "The smaller is: i ", i
  else if (condition2) then
    print *, "The larger is:  i ", i
  else
    print *, "i,j are the same: ", i
  end if

end program example1
