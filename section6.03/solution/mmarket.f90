module mmarket

  ! A simple sparse matrix type, and a function to read a Matrix Market
  ! format ASCII file and return an object of this type.

  ! We assume the data type is real (1.d0)

  implicit none

  integer, parameter :: m_kind = kind(1.d0)

  type :: mm_matrix
     integer                           :: nrows
     integer                           :: ncols
     integer                           :: nentries  ! number of non-zeros
     integer,              allocatable :: i1(:)     ! row indices (1:nentries)
     integer,              allocatable :: j1(:)     ! col indices ditto
     real (kind = m_kind), allocatable :: a(:)      ! matrix elements ditto
  end type mm_matrix

contains

  function mm_matrix_from_file(filename, mm) result(ierr)

    ! Return an initialised matric from the given file name.
    ! This version omits explicit error handling in the interests
    ! of avoiding unnecessary details.

    character (len = *), intent(in)  :: filename
    type (mm_matrix),    intent(out) :: mm
    integer                          :: ierr

    integer :: myunit
    integer :: n

    ! We have to make some assumption about the maximum length of the
    ! text lines. One should allow for possible end-of-record
    character (len = 256) :: header
    character (len = 256) :: comment

    ierr = 0

    open(newunit = myunit, file = filename, form = 'formatted', &
         action = 'read', status = 'old')

    ! read header
    read (myunit, fmt = *) header

    ! zero or more comments: read until we have a non-comment and then
    ! backspace one record
    do
      read (myunit, fmt = *) comment
      if (comment(1:1) /= "%") exit
    end do

    backspace(myunit)

    ! rows, cols, non-zeros
    read (myunit, fmt = *) mm%nrows, mm%ncols, mm%nentries

    allocate(mm%i1(1:mm%nentries))
    allocate(mm%j1(1:mm%nentries))
    allocate(mm%a (1:mm%nentries))

    do n = 1, mm%nentries
      read (myunit, fmt = *) mm%i1(n), mm%j1(n), mm%a(n)
    end do

    close(myunit, status = 'keep')
    
  end function mm_matrix_from_file

end module mmarket
