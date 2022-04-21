program solution_program

  ! Establish a logical array an write out a suitable pbm file.

  use solution_module
  implicit none

  integer, parameter        :: n = 49
  logical, dimension(n,2*n) :: map

  integer :: i, ierr

  ! Set top row, left column, and the diagonal

  map(:,:) = .false.
  map(1,:) = .true.
  map(:,1) = .true.

  do i = 1, n
     map(i,i) = .true.
  end do

  call write_pbm(map, "test49.pbm", ierr)

  print *, "Return value was ", ierr

end program solution_program
