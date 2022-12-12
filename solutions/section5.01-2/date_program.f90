program date_program

  use date_module
  implicit none

  type (my_type) :: date

  date%day = 21
  date%month = 4
  date%year = 2022

  ! Some valid date examples ...

  print *, "List directed date output:     ", date
  print "(a,dt)", "Default dt format:      ", date
  print "(a,dt(2,4,5))", "vlist dt format: ", date

end program date_program
