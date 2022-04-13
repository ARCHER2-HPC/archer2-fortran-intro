program example1

  ! Array declarations/constructors ...
  ! ... and some intrinsic functions

  implicit none

  real, dimension(3)    :: a1
  real, dimension(-2:1) :: b1

  integer, dimension(2,3) :: m = reshape([ 1, 2, 3, 4, 5, 6], shape = [2,3]) 

  ! Fixed arrays with constructors
  integer, dimension(3), parameter :: s = (/ -1, 0, +1 /)  ! F2003 or   
  integer, dimension(3), parameter :: t =  [ -1, 0, +1 ]   ! F2008

  integer :: i, j

  ! Check the lower and upper bounds of a1, b1
  ! via intrinsic functions lbound() and ubound()

  print *, "bounds of a1 are: ", lbound(a1), ubound(a1)
  print *, "bounds of b1 are: ", lbound(b1), ubound(b1)

  ! Check the size and shape of m with size() and shape()
  print *, "size(m) is:  ", size(m)
  print *, "shape(m) is: ", shape(m)

  ! Elements of s(3)  and t(3)
  do j = 1,3
     print *, "j s(j) t(j): ", j, s(j), t(j)
  end do

  ! Elements of m(2,3) in array element order
  do j = 1, 3
    do i = 1, 2
        print *, "i j m(i,j): ", i, j, m(i,j)
    end do
  end do

end program example1
