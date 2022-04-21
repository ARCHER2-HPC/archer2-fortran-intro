program example1

  ! Example format specifiers

  use iso_fortran_env
  implicit none

  integer              :: ivar = 40
  logical              :: lvar = .false.
  real (real64)        :: avar = 40.0
  character (len = 10) :: cvar = "Hello"

  print "('Format i10:    ',    i10)", ivar
  print "('Format i10.10: ', i10.10)", ivar
  print "('Format l10:    ',    l10)", lvar
  print "('Format f10.3:  ',  f10.3)", avar
  print "('Format e10.3:  ',  e10.3)", avar
  print "('Format en10.3: ', en10.3)", avar
  print "('Format a10:    ',    a10)", cvar
  ! Botched format specifiers

  ivar = -40
  avar = huge(avar)

  print "('Format i1:     ',    i 2)", ivar
  print "('Format f10.3:  ',  f10.3)", avar
  print "('Format e10.3:  ',  e10.3)", avar

  print "('Others:')"
  print "('Format sp,e12.3: ', sp,e12.4)", avar
  print "('Format e12.3e4:  ',  e12.3e4)", avar

end program example1
