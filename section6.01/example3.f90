program example3

  ! Polymorphism logical and inter image arrays

  use pbm_image
  implicit none

  integer, parameter        :: n = 49
  logical, dimension(n,2*n) :: map
  integer, dimension(n,2*n) :: imap

  integer :: i, ierr

  ! Set top row, left column, and the diagonal

  map(:,:) = .false.
  map(1,:) = .true.
  map(:,1) = .true.

  do i = 1, n
    map(i,i) = .true.
  end do

  call write_pbm(map, "logical49.pbm", ierr)

  print *, "Return value was ", ierr

  ! Integer version

  where (map(:,:) .eqv. .true.)
    imap(:,:) = 0
  elsewhere
    imap(:,:) = -1
  end where

  call write_pbm(imap, "integer49.pbm", ierr)

  print *, "Return value was ", ierr

end program example3
