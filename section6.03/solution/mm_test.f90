program mm_test

  ! Test for accompanying module to read a Matrix Market file.

  ! This one is
  ! https://math.nist.gov/MatrixMarket/data/Harwell-Boeing/bcsstruc1/bcsstk08.html
  ! which needs to be downloaded.

  use mmarket
  implicit none

  type (mm_matrix) :: mm
  integer          :: ierr

  ierr = mm_matrix_from_file("bcsstk08.mtx", mm)
  print *, "Matrix nrows, ncols, non-zeros: ", mm%nrows, mm%ncols, mm%nentries

end program mm_test
