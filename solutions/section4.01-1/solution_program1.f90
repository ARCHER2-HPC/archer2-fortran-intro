program exercise_program1

  ! String functions test

  use exercise_module1
  implicit none

  character (len = *), parameter   :: ref = "ABCabc123"
  character (len = :), allocatable :: tstring

  tstring = ref
  print *, "Input to test 1: ", tstring
  call string_to_lower_case(tstring)
  print *, "Result of test 1: ", tstring

  tstring = ref
  print *, "Input to test 2: ", tstring
  tstring = to_lower_case(tstring)
  print *, "Result of test 2: ", tstring

end program exercise_program1
