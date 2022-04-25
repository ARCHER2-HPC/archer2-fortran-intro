module pbm_image

  ! PBM images
  ! Add a relevant declarations for a public "write_pbm"

  implicit none
  private

contains

  pure function logical_to_pbm(lvar) result (ivar)

    ! Utility to return 0 or 1 for .false. and .true.

    logical, intent(in) :: lvar
    integer             :: ivar

    ivar = 0
    if (lvar) ivar = 1
    
  end function logical_to_pbm

  pure function integer_to_pbm(ival) result(ilog)

    ! Return 0 if ival is 0, 1 otherwise

    integer, intent(in) :: ival
    integer             :: ilog

    ilog = 0
    if (ival /= 0) ilog = 1

  end function integer_to_pbm

  subroutine write_logical_pbm(map, filename, ierr)

    ! Write the map array to a PBM file with filename "filename".
    ! Returns zero on success.

    logical, dimension(:,:), intent(in)  :: map
    character (len = *),     intent(in)  :: filename
    integer,                 intent(out) :: ierr

    ! We do this via an integer array...

    integer, dimension(size(map, dim=1), size(map, dim=2)) :: imap
    integer :: i, j

    do j = 1, size(map, dim = 2)
       do i = 1, size(map, dim = 1)
          imap(i,j) = logical_to_pbm(map(i,j))
       end do
    end do

    call write_integer_pbm(imap, filename, ierr)

  end subroutine write_logical_pbm

  subroutine write_integer_pbm(imap, filename, ierr)

    ! Write the integer array imap(:,:) to a PBM file "fileanme"
    ! Returns zero on success.

    ! imap elements translated to either 0 or 1 via integer_to_pbm()

    integer, dimension(:,:), intent(in)  :: imap
    character (len = *),     intent(in)  :: filename
    integer,                 intent(out) :: ierr

    integer :: myunit
    integer :: nrows, ncols, i, j
    character (len = 256) :: msg

    nrows = size(imap, dim = 1)
    ncols = size(imap, dim = 2)
    msg = ''

    open(newunit = myunit, file = filename, form = 'formatted', &
         action = 'write', status = 'new', err = 999, iomsg = msg)

    ! header: note the transpose (ncols, nrows)
    write (myunit, fmt = '(a2)', err = 998, iomsg = msg) "P1"
    write (myunit, fmt = '(a)',  err = 998, iomsg = msg) "# From Fortran"
    write (myunit, fmt = '(2(1x,i0))', err = 998, iomsg = msg) ncols, nrows

    ! data
    do i = 1, nrows
       do j = 1, ncols - 1
          write (myunit, fmt = '(i1,x)', advance = 'no') &
               integer_to_pbm(imap(i,j))
       end do
       write (myunit, fmt = '(i1)') integer_to_pbm(imap(i,ncols))
    end do

    close (myunit, status = 'keep')

    ierr = 0
    return

999 continue
    ! Failed to open file (could go to error_unit...)
    print *, "write_pbm: open: ", trim(msg)
    ierr = -1
    return

998 continue
    ! write failed
    print *, "write_pbm: write: ", trim(msg)
    ierr = -2
    return

  end subroutine write_integer_pbm

end module pbm_image
