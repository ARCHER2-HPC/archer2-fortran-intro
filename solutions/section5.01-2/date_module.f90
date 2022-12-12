module date_module

  ! A module which defines a simple date type, and overrides the
  ! default formatted write.

  implicit none

  type :: my_type
     integer :: day = 0
     integer :: month = 0
     integer :: year = 0
   contains
     procedure :: write_my_type
     generic   :: write(formatted) => write_my_type
  end type my_type

  ! Define some months, so we can produce formats like "12 Dec 2022"
  character (len = 3), dimension(12), parameter :: months = &
       [character (len = 3) :: "Jan", "Feb", "Mar", "Apr", "May", "Jun", &
                               "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"  ]
contains

  subroutine write_my_type(self, unit, iotype, vlist, iostat, iomsg)

    class (my_type),     intent(in)    :: self
    integer,             intent(in)    :: unit
    character (len = *), intent(in)    :: iotype
    integer,             intent(in)    :: vlist(:)
    integer,             intent(out)   :: iostat
    character (len = *), intent(inout) :: iomsg

    character (len = *), parameter :: dfmt = "(i2.2,'/',i2.2,'/',i4)"
    iostat = 0   ! we will assume no errors occur (iomsg is unchanged)

    if (iotype == "LISTDIRECTED") then
       write(unit, fmt = dfmt, iostat = iostat) self%day, self%month, self%year
    else
       ! A dt-style format
       ! We will only consider the case of vlist(3)
       if (size(vlist) == 3) then
         block
           character (len = 20) :: userfmt
           write (userfmt, "(a,i1,a,i2,a,i1,a)") &
                "(i", vlist(1), ",a", vlist(2), ",i", vlist(3), ")"
           write(unit, userfmt, iostat = iostat) &
                self%day, months(self%month), self%year
         end block
       else
         ! Handle other conditions; we will just use the default format
         write (unit, dfmt, iostat = iostat) self%day, self%month, self%year
       end if
    end if

  end subroutine write_my_type

end module date_module
