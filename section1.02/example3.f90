program example3

  implicit none

  ! Print kind type parameters, and storage size, for different types

  integer, parameter :: my_e_k = kind(1.e0)
  integer, parameter :: my_d_k = kind(1.d0)

  real (my_e_k) :: a
  real (my_d_k) :: b

  print *, "Kind type parameter for a: ", my_e_k
  print *, "Kind type parameter for b: ", my_d_k

  print *, "Storage size(a):           ", storage_size(a)
  print *, "Storage size(b):           ", storage_size(b)

end program example3
