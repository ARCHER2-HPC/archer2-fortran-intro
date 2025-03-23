program exercise

  ! Tri-diagonal matrix problem via Thomas' algorithm
  ! See https://en.wikipedia.org/wiki/Tridiagonal_matrix_algorithm

  ! We will write a program to solve the tri-diagonal matrix problem
  !   a_i x_i-1 + b_i x_i + c_i x_i+1 = d_i
  ! Follow the description at the web page above.

  ! Consider a small problem with n = 4
  ! The following values can be used as a test:
  !   a =      [1.0, 1.0, 1.0]
  !   b = [4.0, 4.0, 4.0, 4.0]
  !   c = [2.0, 2.0, 2.0]
  !   d = [1.0, 4.0, 5.0, 6.0]
  ! which should give a solution approx. x = [-0.195, 0.890, 0.317, 1.42]

  ! 1. Implement the algorithm following the pseudocode.
  ! 2. Check the answer
  ! 3. Construct the full matrix and use the intrinsic function
  !    matmul(a, x) to check the answer for a different d. The
  !    arguments a and x may be an appropriate combination of
  !    matrix and vector.
  ! 4. The above reference states that the algorithm is stable if
  !    the matrix is diagonally dominant. Check this is the case
  !    before entering the solution phase.
  !    See also https://en.wikipedia.org/wiki/Diagonally_dominant_matrix

end program exercise
