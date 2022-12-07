program example1

  implicit none

  character (len = 20) :: file_stub
  character (len = 10) :: file_ext

  file_stub = "filename"
  file_ext  = "ext"

  print *, "len(file_stub):        ", len(file_stub)
  print *, "len_trim(file_stub):   ", len_trim(file_stub)

  print *, "File name: ", trim(file_stub)//"."//file_ext(1:3)

end program example1
